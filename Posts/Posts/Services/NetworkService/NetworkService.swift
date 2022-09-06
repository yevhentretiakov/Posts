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
    func request(with url: String) -> DataRequest
}

class DefaultNetworkService: NetworkService {
    // MARK: - Methods
    func request(with url: String) -> DataRequest {
        AF.request(url)
    }
}
