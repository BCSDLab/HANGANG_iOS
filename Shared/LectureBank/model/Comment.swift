//
//  Comment.swift
//  hangang (iOS)
//
//  Created by 정태훈 on 2021/06/25.
//

import Foundation

struct Comment: Codable, Hashable {
    let id, lectureBankID, userID: Int
    let nickname, comments, createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id
        case lectureBankID = "lecture_bank_id"
        case userID = "user_id"
        case nickname, comments
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
    
    func hash(into hasher: inout Hasher) {
           hasher.combine(id)
        }
    
    static func == (lhs: Comment, rhs: Comment) -> Bool {
        return lhs.id == rhs.id
    }
}
