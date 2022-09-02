//
//  FeedModulePresenter.swift
//  Posts
//
//  Created by Yevhen Tretiakov on 02.09.2022.
//

import Foundation

// MARK: - Protocols
protocol FeedView: AnyObject {
    
}

protocol FeedPresenter {
    
}

final class DefaultFeedPresenter: FeedPresenter {
    // MARK: - Properties
    private weak var view: FeedView?
    private let router: FeedRouter
    
    // MARK: - Life Cycle Methods
    init(view: FeedView, router: FeedRouter) {
        self.view = view
        self.router = router
    }
    
    // MARK: - Methods
}
