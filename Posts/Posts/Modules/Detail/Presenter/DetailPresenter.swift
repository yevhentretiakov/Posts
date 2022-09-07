//
//  DetailPresenter.swift
//  Posts
//
//  Created by Yevhen Tretiakov on 07.09.2022.
//

import Foundation

// MARK: - Protocols
protocol DetailView: AnyObject {
    func presentAlert(title: String, message: String)
    func configurePost(with model: PostDetailModel)
}

protocol DetailPresenter {
    func viewDidLoad(withPostId id: Int)
}

final class DefaultDetailPresenter: DetailPresenter {
    // MARK: - Properties
    private weak var view: DetailView?
    private let router: DetailRouter
    private let networkService: DetailNetworkService
    
    // MARK: - Life Cycle Methods
    init(view: DetailView, router: DetailRouter, networkService: DetailNetworkService) {
        self.view = view
        self.router = router
        self.networkService = networkService
    }
    
    // MARK: - Internal Methods
    func viewDidLoad(withPostId id: Int) {
        fetchPost(with: id)
    }
    
    // MARK: - Private Methods
    private func fetchPost(with id: Int) {
        networkService.fetchPost(with: id) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let post):
                DispatchQueue.main.async {
                    self.view?.configurePost(with: post)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.view?.presentAlert(title: "Network Error", message: error.localizedDescription)
                }
            }
        }
    }
}
