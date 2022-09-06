//
//  FeedPresenter.swift
//  Posts
//
//  Created by Yevhen Tretiakov on 02.09.2022.
//

import Foundation

// MARK: - Protocols
protocol FeedView: AnyObject {
    func reloadTableView()
    func presentAlert(title: String, message: String)
}

protocol FeedPresenter {
    func viewDidLoad()
    func getItemsCount() -> Int
    func getItem(at index: Int) -> PostModel
    func sortByDate()
    func sortByLikes()
    func toggleButtonTapped(at index: Int)
}

final class DefaultFeedPresenter: FeedPresenter {
    // MARK: - Properties
    private weak var view: FeedView?
    private let router: FeedRouter
    private let networkService: FeedNetworkService
    
    private var posts = [PostModel]()
    
    // MARK: - Life Cycle Methods
    init(view: FeedView, router: FeedRouter, networkService: FeedNetworkService) {
        self.view = view
        self.router = router
        self.networkService = networkService
    }
    
    // MARK: - Private Methods
    private func fetchPosts() {
        networkService.fetchPosts { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let posts):
                self.posts = posts
                DispatchQueue.main.async {
                    self.view?.reloadTableView()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.view?.presentAlert(title: "Network Error", message: error.localizedDescription)
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
    
    func getItem(at index: Int) -> PostModel {
        return posts[index]
    }
    
    func sortByDate() {
        posts.sort(by: { $0.timeshamp > $1.timeshamp })
        view?.reloadTableView()
    }
    
    func sortByLikes() {
        posts.sort(by: { $0.likesCount > $1.likesCount })
        view?.reloadTableView()
    }
    
    func toggleButtonTapped(at index: Int) {
        posts[index].isExpanded?.toggle()
        view?.reloadTableView()
    }
}
