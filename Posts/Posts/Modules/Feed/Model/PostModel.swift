//
//  PostModel.swift
//  Posts
//
//  Created by Yevhen Tretiakov on 02.09.2022.
//

import Foundation

struct PostsResponse: Codable {
    let posts: [PostNetworkModel]
}

struct PostNetworkModel: Codable {
    let postId: Int
    let timeshamp: Int
    let title: String
    let previewText: String
    let likesCount: Int
}

struct PostUIModel {
    let postId: Int
    let timeshamp: Int
    let title: String
    let previewText: String
    let likesCount: Int
    var isExpanded: Bool = false
}
