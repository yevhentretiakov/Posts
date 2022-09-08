//
//  FeedAPIService.swift
//  Posts
//
//  Created by Yevhen Tretiakov on 02.09.2022.
//

import UIKit
import Alamofire

typealias PostModelResult = (Result<[PostNetworkModel], AFError>) -> Void

// MARK: - Protocols
protocol FeedNetworkService {
    func fetchPosts(completion: @escaping PostModelResult)
}

final class DefaultFeedNetworkService: FeedNetworkService {
    // MARK: - Properties
    private let networkService: NetworkService
    private let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    // MARK: - Life Cycle Methods
    init(networkService: NetworkService = DefaultNetworkService()) {
        self.networkService = networkService
    }
    
    // MARK: - Internal Methods
    func fetchPosts(completion: @escaping PostModelResult) {
        networkService.request(.fetchPosts).responseDecodable(of: PostsResponse.self, decoder: decoder) { response in
                if let error = response.error {
                    completion(.failure(error))
                } else {
                    completion(.success(response.value?.posts ?? [PostNetworkModel]()))
                }
            }
    }
}
