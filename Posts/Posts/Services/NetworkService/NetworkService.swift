//
//  NetworkService.swift
//  Posts
//
//  Created by Yevhen Tretiakov on 06.09.2022.
//

import Foundation
import Alamofire

typealias AFResponse<T> = (AFDataResponse<T>) -> Void

// MARK: - Protocols
protocol NetworkService {
    func get<T: Decodable>(_ type: T.Type, from endpoint: ApiEndpoint, completion: @escaping AFResponse<T>)
}

class DefaultNetworkService: NetworkService {
    // MARK: - Properties
    private static let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    // MARK: - Methods
    func get<T: Decodable>(_ type: T.Type, from endpoint: ApiEndpoint, completion: @escaping AFResponse<T>) {
        AF.request(endpoint.url).responseDecodable(of: type, decoder: DefaultNetworkService.decoder, completionHandler: completion)
    }
}
