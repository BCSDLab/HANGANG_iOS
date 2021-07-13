//
//  LectureCount.swift
//  hangang (iOS)
//
//  Created by 정태훈 on 2021/05/16.
//

import Foundation

struct LectureCount: Codable {
    //let getLectureBankCommentCount: Int?
    let getLectureBankCommentCount, lectureReview, getLectureBankCount: Int?

    enum CodingKeys: String, CodingKey {
        case getLectureBankCommentCount
        case lectureReview = "LectureReview"
        case getLectureBankCount
    }
}
