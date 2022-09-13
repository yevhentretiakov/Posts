//
//  PostDetailModel.swift
//  Posts
//
//  Created by Yevhen Tretiakov on 07.09.2022.
//

import Foundation

struct PostDetailResponse: Codable {
    let post: PostDetailModel
}

struct PostDetailModel: Codable {
    let postId: Int
    let timeshamp: Int
    let title: String
    let body: String
    let imageUrl: String
    let likesCount: Int
    
    enum CodingKeys: String, CodingKey {
        case postId
        case timeshamp
        case title
        case body = "text"
        case imageUrl = "postImage"
        case likesCount
    }
}
