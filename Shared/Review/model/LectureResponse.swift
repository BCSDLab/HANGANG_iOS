//
//  LectureResponse.swift
//  hangang (iOS)
//
//  Created by 정태훈 on 2021/05/30.
//

import Foundation

struct LectureResponse: Codable {
    let result: [Lecture]?
    let count: Int

    enum CodingKeys: String, CodingKey {
        case result
        case count
    }
}
