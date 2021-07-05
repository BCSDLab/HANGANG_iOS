//
//  CommentResponse.swift
//  hangang (iOS)
//
//  Created by 정태훈 on 2021/06/25.
//

import Foundation
struct CommentResponse<T: Codable>: Codable {
    let comments: [T]?
    let count: Int

    enum CodingKeys: String, CodingKey {
        case comments
        case count
    }
}
