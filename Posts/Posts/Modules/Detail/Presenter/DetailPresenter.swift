//
//  DetailPresenter.swift
//  Posts
//
//  Created by Yevhen Tretiakov on 07.09.2022.
//

import Foundation

// MARK: - Protocols
protocol DetailView: AnyObject {
    func showMessage(title: String, message: String)
    func configurePost(with model: PostDetailModel)
}

protocol DetailPresenter {
    func viewDidLoad()
}

final class DefaultDetailPresenter: DetailPresenter {
    // MARK: - Properties
    private weak var view: DetailView?
    private let router: DetailRouter
    private let repository: DetailRepository
    private let postId: Int
    
    // MARK: - Life Cycle Methods
    init(view: DetailView, postId: Int, router: DetailRouter, repository: DetailRepository) {
        self.view = view
        self.router = router
        self.repository = repository
        self.postId = postId
    }
    
    // MARK: - Internal Methods
    func viewDidLoad() {
        fetchPostDetails(with: postId)
    }
    
    // MARK: - Private Methods
    private func fetchPostDetails(with id: Int) {
        repository.fetchPostDetails(with: id) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let post):
                if let post = post {
                    DispatchQueue.main.async {
                        self.view?.configurePost(with: post)
                    }
                }  else {
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
}
