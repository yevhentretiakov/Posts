//
//  DetailNetworkService.swift
//  Posts
//
//  Created by Yevhen Tretiakov on 07.09.2022.
//

import Foundation
import Alamofire

typealias PostDetailModelResult = (Result<PostDetailModel?, AFError>) -> Void

// MARK: - Protocols
protocol DetailRepository {
    func fetchPostDetails(with id: Int, completion: @escaping PostDetailModelResult)
}

final class DefaultDetailRepository: DetailRepository {
    // MARK: - Properties
    private let networkService: NetworkService
    
    // MARK: - Life Cycle Methods
    init(networkService: NetworkService = DefaultNetworkService()) {
        self.networkService = networkService
    }
    
    // MARK: - Methods
    func fetchPostDetails(with id: Int, completion: @escaping PostDetailModelResult) {
        networkService.request(PostDetailResponse.self, from: .fetchPostDetails(id: id)) { response in
            if let error = response.error {
                completion(.failure(error))
            } else {
                completion(.success(response.value?.post))
            }
        }
    }
}
