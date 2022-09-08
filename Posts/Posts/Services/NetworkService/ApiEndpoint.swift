//
//  ApiEndpoint.swift
//  Posts
//
//  Created by Yevhen Tretiakov on 08.09.2022.
//

import Foundation

// MARK: - Enums
enum ApiEndpoint {
    case fetchPosts
}

// MARK: - Protocols
protocol HTTPRequest {
    var url: String { get }
}

// MARK: - HTTPRequest
extension ApiEndpoint: HTTPRequest {
    var url: String {
        switch self {
        case .fetchPosts:
            let baseURL = "https://raw.githubusercontent.com/anton-natife/jsons/master/api"
            let path = "/main.json"
            return baseURL + path
        }
    }
}
