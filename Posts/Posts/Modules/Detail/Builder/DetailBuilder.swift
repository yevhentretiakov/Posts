//
//  DetailBuilder.swift
//  Posts
//
//  Created by Yevhen Tretiakov on 07.09.2022.
//

import UIKit

// MARK: - Protocols
protocol DetailBuilder {
    func createDetailModule() -> UIViewController
}

final class DefaultDetailBuilder {
    // MARK: - Methods
    func createDetailModule(withPostId id: Int) -> UIViewController {
        let view = DetailViewController()
        let router = DefaultDetailRouter(viewController: view)
        let repository = DefaultDetailRepository()
        let presenter = DefaultDetailPresenter(view: view, postId: id, router: router, repository: repository)
        view.presenter = presenter
        return view
    }
}
