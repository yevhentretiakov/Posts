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
}

protocol FeedPresenter {
    func viewDidLoad()
    func getItemsCount() -> Int
    func getItem(at index: Int) -> PostModel
    func sortByDate()
    func sortByLikes()
}

final class DefaultFeedPresenter: FeedPresenter {
    // MARK: - Properties
    private weak var view: FeedView?
    private let router: FeedRouter
    
    private var posts = [
        PostModel(postId: 123, timeshamp: 1645030659, title: "Post 1", previewText: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.", likesCount: 12),
        PostModel(postId: 22, timeshamp: 1648809255, title: "Post 2", previewText: "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. ", likesCount: 44),
        PostModel(postId: 3, timeshamp: 1648987815, title: "Post 3", previewText: "Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", likesCount: 23)
    ]
    
    // MARK: - Life Cycle Methods
    init(view: FeedView, router: FeedRouter) {
        self.view = view
        self.router = router
    }
    
    // MARK: - Methods
    func viewDidLoad() {
        
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
}
