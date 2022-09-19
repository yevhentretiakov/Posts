//
//  FeedPresenter.swift
//  Posts
//
//  Created by Yevhen Tretiakov on 02.09.2022.
//

import Foundation

// MARK: - Enums
enum SortType {
    case likesCount
    case date
}

// MARK: - Protocols
protocol FeedView: AnyObject {
    func reloadData()
    func showMessage(title: String, message: String)
}

protocol FeedPresenter {
    func viewDidLoad()
    func getItemsCount() -> Int
    func getItem(at index: Int) -> PostUIModel
    func sortPosts(by sortType: SortType)
    func toggleButtonTappedInPost(with id: Int)
    func postTapped(with index: Int)
    func setSearchText(_ text: String)
}

final class DefaultFeedPresenter: FeedPresenter {
    // MARK: - Properties
    private weak var view: FeedView?
    private let router: FeedRouter
    private let repository: FeedRepository
    private var posts = [PostUIModel]()
    private var searchText = "" {
        didSet {
            updateSearchResults()
        }
    }
    
    private var timer: Timer?
    
    // MARK: - Life Cycle Methods
    init(view: FeedView, router: FeedRouter, repository: FeedRepository) {
        self.view = view
        self.router = router
        self.repository = repository
    }
    
    // MARK: - Private Methods
    private func fetchPosts() {
        repository.fetchPosts { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let posts):
                if let posts = posts {
                    self.posts = posts.map({ post in
                        PostUIModel(postId: post.postId,
                                    timeshamp: post.timeshamp,
                                    title: post.title,
                                    previewText: post.previewText,
                                    likesCount: post.likesCount)
                    })
                    DispatchQueue.main.async {
                        self.view?.reloadData()
                    }
                } else {
                    DispatchQueue.main.async {
                        self.view?.showMessage(title: "Network Error", message: "Please try again later...")
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.view?.showMessage(title: "Network Error", message: error.localizedDescription)
                }
            }
        }
    }
    
    private func updateSearchResults() {
        timer?.invalidate()
        if searchText.count >= 2 {
            timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(fetchSearch), userInfo: nil, repeats: false)
        } else {
            fetchPosts()
        }
    }
    
    @objc private func fetchSearch() {
        repository.fetchSearch(with: searchText) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let posts):
                if let posts = posts {
                    self.posts = posts.map({ post in
                        PostUIModel(postId: post.postId,
                                    timeshamp: post.timeshamp,
                                    title: post.title,
                                    previewText: post.previewText,
                                    likesCount: post.likesCount)
                    }).filter { post in
                        post.title.lowercased().contains(self.searchText.lowercased()) ||
                        post.previewText.lowercased().contains(self.searchText.lowercased())
                    }
                    DispatchQueue.main.async {
                        self.view?.reloadData()
                    }
                } else {
                    DispatchQueue.main.async {
                        self.view?.showMessage(title: "Network Error", message: "Please try again later...")
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.view?.showMessage(title: "Network Error", message: error.localizedDescription)
                }
            }
        }
    }
    
    // MARK: - Internal Methods
    func viewDidLoad() {
        fetchPosts()
    }
    
    func getItemsCount() -> Int {
        return posts.count
    }
    
    func getItem(at index: Int) -> PostUIModel {
        return posts[index]
    }
    
    func sortPosts(by sortType: SortType) {
        switch sortType {
        case .likesCount:
            posts.sort(by: { $0.likesCount > $1.likesCount })
        case .date:
            posts.sort(by: { $0.timeshamp > $1.timeshamp })
        }
        view?.reloadData()
    }
    
    func toggleButtonTappedInPost(with id: Int) {
        if let index = posts.firstIndex(where: { $0.postId == id }) {
            posts[index].isExpanded.toggle()
        }
        view?.reloadData()
    }
    
    func postTapped(with index: Int) {
        let postId = posts[index].postId
        router.showPostDetails(with: postId)
    }
    
    func setSearchText(_ text: String) {
        searchText = text
        view?.reloadData()
    }
}
