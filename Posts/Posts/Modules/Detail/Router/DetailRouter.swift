//
//  DetailRouter.swift
//  Posts
//
//  Created by Yevhen Tretiakov on 07.09.2022.
//

import Foundation

// MARK: - Protocols
protocol DetailRouter {
    func close()
}

final class DefaultDetailRouter: DefaultBaseRouter, DetailRouter {
    // MARK: - Properties
    func close() {
        close(animated: true)
    }
}
