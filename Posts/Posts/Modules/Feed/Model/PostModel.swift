//
//  PostModel.swift
//  Posts
//
//  Created by Yevhen Tretiakov on 02.09.2022.
//

import Foundation

struct PostsResponse: Codable {
    let posts: [PostModel]
}

struct PostModel: Codable {
    let postId: Int
    let timeshamp: Int
    let title: String
    let previewText: String
    let likesCount: Int
    
    enum CodingKeys: String, CodingKey {
        case postId
        case timeshamp
        case title
        case previewText = "preview_text"
        case likesCount = "likes_count"
    }
}

