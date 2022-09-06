//
//  FeedAPIService.swift
//  Posts
//
//  Created by Yevhen Tretiakov on 02.09.2022.
//

import UIKit
import Alamofire

typealias PostModelResult = (Result<[PostModel], AFError>) -> Void

// MARK: - Protocols
protocol FeedNetworkService {
    func fetchPosts(completion: @escaping PostModelResult)
}

final class DefaultFeedNetworkService: FeedNetworkService {
    // MARK: - Properties
    private let networkService = DefaultNetworkService()
    
    // MARK: - Methods
    func fetchPosts(completion: @escaping PostModelResult) {
        networkService.request(with: "https://raw.githubusercontent.com/anton-natife/jsons/master/api/main.json").responseDecodable(of: PostsResponse.self) { response in
                if let error = response.error {
                    completion(.failure(error))
                }
                if let posts = response.value?.posts {
                    completion(.success(posts))
                }
            }
    }
}
