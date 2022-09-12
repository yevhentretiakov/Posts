//
//  ApiEndpoint.swift
//  Posts
//
//  Created by Yevhen Tretiakov on 08.09.2022.
//

import Foundation
import Alamofire

// MARK: - Enums
enum ApiEndpoint {
    case fetchPosts
    static let baseURL = "https://raw.githubusercontent.com/anton-natife/jsons/master/api/"
}

// MARK: - Protocols
protocol HTTPRequest {
    var url: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: HTTPHeaders? { get }
    var parameters: Parameters? { get }
    var encoding: URLEncoding { get }
}

// MARK: - HTTPRequest
extension ApiEndpoint: HTTPRequest {
    var url: String {
        switch self {
        case .fetchPosts:
            return ApiEndpoint.baseURL
        }
    }
    var path: String {
        switch self {
        case .fetchPosts:
            return "\(url)main.json"
        }
    }
    var method: HTTPMethod {
        switch self {
        case .fetchPosts:
            return .get
        }
    }
    var headers: HTTPHeaders? {
        switch self {
        case .fetchPosts:
            return nil
        }
    }
    var parameters: Parameters? {
        switch self {
        case .fetchPosts:
            return nil
        }
    }
    var encoding: URLEncoding {
        switch self {
        case .fetchPosts:
            return .default
        }
    }
}
