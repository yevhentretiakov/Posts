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
        view.postId = id
        let router = DefaultDetailRouter(viewController: view)
        let networkService = DefaultDetailNetworkService()
        let presenter = DefaultDetailPresenter(view: view, router: router, networkService: networkService)
        view.presenter = presenter
        return view
    }
}
