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
    func request<T: Decodable>(_ type: T.Type, from endpoint: ApiEndpoint, completion: @escaping AFResponse<T>)
    func cancel()
}

final class DefaultNetworkService: NetworkService {
    // MARK: - Properties
    private static let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    private var request: DataRequest?
    
    // MARK: - Methods
    func request<T: Decodable>(_ type: T.Type, from endpoint: ApiEndpoint, completion: @escaping AFResponse<T>) {
        request = AF.request(endpoint.path,
                   method: endpoint.method,
                   parameters: endpoint.parameters,
                   encoding: endpoint.encoding,
                   headers: endpoint.headers)
        .responseDecodable(of: type, decoder: DefaultNetworkService.decoder, completionHandler: completion)
    }
    
    func cancel() {
        request?.cancel()
    }
}
