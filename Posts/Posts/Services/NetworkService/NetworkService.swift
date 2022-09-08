//
//  NetworkService.swift
//  Posts
//
//  Created by Yevhen Tretiakov on 06.09.2022.
//

import Foundation
import Alamofire

// MARK: - Protocols
protocol NetworkService {
    func request(_ endpoint: ApiEndpoint) -> DataRequest
}

class DefaultNetworkService: NetworkService {
    // MARK: - Methods
    func request(_ endpoint: ApiEndpoint) -> DataRequest {
        AF.request(endpoint.url)
    }
}
