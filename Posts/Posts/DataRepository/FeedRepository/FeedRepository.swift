//
//  FeedAPIService.swift
//  Posts
//
//  Created by Yevhen Tretiakov on 02.09.2022.
//

import UIKit
import Alamofire

typealias PostModelResult = (Result<[PostNetworkModel]?, AFError>) -> Void

// MARK: - Protocols
protocol FeedRepository {
    func fetchPosts(completion: @escaping PostModelResult)
    func fetchSearch(with string: String, completion: @escaping PostModelResult)
}

final class DefaultFeedRepository: FeedRepository {
    // MARK: - Properties
    private let networkService: NetworkService
    
    // MARK: - Life Cycle Methods
    init(networkService: NetworkService = DefaultNetworkService()) {
        self.networkService = networkService
    }
    
    // MARK: - Internal Methods
    func fetchPosts(completion: @escaping PostModelResult) {
        networkService.cancel()
        networkService.request(PostsResponse.self, from: .fetchPosts) { response in
            if let error = response.error {
                completion(.failure(error))
            } else {
                completion(.success(response.value?.posts))
            }
        }
    }
    
    func fetchSearch(with string: String, completion: @escaping PostModelResult) {
        networkService.cancel()
        networkService.request(PostsResponse.self, from: .fetchSearch(withString: string)) { response in
            if let error = response.error {
                completion(.failure(error))
            } else {
                completion(.success(response.value?.posts))
            }
        }
    }
}
