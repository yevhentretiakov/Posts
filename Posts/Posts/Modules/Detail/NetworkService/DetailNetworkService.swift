//
//  DetailNetworkService.swift
//  Posts
//
//  Created by Yevhen Tretiakov on 07.09.2022.
//

import Foundation
import Alamofire

typealias PostDetailModelResult = (Result<PostDetailModel, AFError>) -> Void

// MARK: - Protocols
protocol DetailNetworkService {
    func fetchPost(with id: Int, completion: @escaping PostDetailModelResult)
}

final class DefaultDetailNetworkService: DetailNetworkService {
    // MARK: - Properties
    private let networkService = DefaultNetworkService()
    
    // MARK: - Methods
    func fetchPost(with id: Int, completion: @escaping PostDetailModelResult) {
        networkService.request(with: "https://raw.githubusercontent.com/anton-natife/jsons/master/api/posts/\(id).json").responseDecodable(of: PostDetailResponse.self) { response in
                if let error = response.error {
                    completion(.failure(error))
                }
                if let post = response.value?.post {
                    completion(.success(post))
                }
            }
    }
}
