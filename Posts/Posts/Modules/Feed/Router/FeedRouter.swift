//
//  FeedRouter.swift
//  Posts
//
//  Created by Yevhen Tretiakov on 02.09.2022.
//

import UIKit

// MARK: - Protocols
protocol FeedRouter {
    func showPostDetails(with id: Int)
}

final class DefaultFeedRouter: DefaultBaseRouter, FeedRouter {
    func showPostDetails(with id: Int) {
        let postDetailsViewController = DefaultDetailBuilder().createDetailModule(withPostId: id)
        show(viewController: postDetailsViewController, isModal: false, animated: true)
    }
}
