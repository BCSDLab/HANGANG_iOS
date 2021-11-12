//
//  Purchase.swift
//  hangang (iOS)
//
//  Created by 정태훈 on 2021/05/17.
//

import Foundation

struct Purchase: Codable, Hashable {
    let id, userID: Int
    let title: String
    let lecture: Lecture
    let uploadFiles: [UploadFile]

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case title, lecture, uploadFiles
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func ==(lhs: Purchase, rhs: Purchase) -> Bool {
        if lhs.id != rhs.id {
            return false
        }
        return true
    }
}
