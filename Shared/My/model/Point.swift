//
//  Point.swift
//  hangang (iOS)
//
//  Created by 정태훈 on 2021/05/23.
//

import Foundation

struct Point: Codable, Hashable {
    let id, userID, variance: Int?
    let title, createdAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case variance, title
        case createdAt = "created_at"
    }
    
    func hash(into hasher: inout Hasher) {
           hasher.combine(id)
        }
    
    static func == (lhs: Point, rhs: Point) -> Bool {
        return lhs.id == rhs.id
    }
}
