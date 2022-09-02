//
//  BaseRouter.swift
//  Posts
//
//  Created by Yevhen Tretiakov on 02.09.2022.
//

import UIKit

// MARK: - Protocols
protocol BaseRouter {
    
}

class DefaultBaseRouter: BaseRouter {
    // MARK: - Properties
    private weak var viewController: UIViewController?
    private var navigationController: UINavigationController? {
        viewController?.navigationController
    }
    
    // MARK: - Life Cycle Methods
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    // MARK: - Methods
}
