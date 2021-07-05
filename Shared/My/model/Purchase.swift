//
//  Purchase.swift
//  hangang (iOS)
//
//  Created by 정태훈 on 2021/05/17.
//

import Foundation

struct Purchase: Codable {
    let id, userID: Int
    let title: String
    let lecture: Lecture
    let uploadFiles: [UploadFile]

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case title, lecture, uploadFiles
    }
}
