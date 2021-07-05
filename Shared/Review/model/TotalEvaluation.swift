//
//  TotalEvaluation.swift
//  hangang (iOS)
//
//  Created by 정태훈 on 2021/06/13.
//

import Foundation

// MARK: - TotalEvaluation
struct TotalEvaluation: Codable {
    let id: JSONNull?
    let lectureID: Int
    let userID, semesterID, semesterDate, nickname: JSONNull?
    let isLiked: Bool
    let rating: Double
    let likes: JSONNull?
    let assignmentAmount, difficulty, gradePortion, attendanceFrequency: Int
    let testTimes, comment, hashTags, assignment: JSONNull?
    let returnID, isDeleted, createdAt, updatedAt: JSONNull?

    enum CodingKeys: String, CodingKey {
        case id
        case lectureID = "lecture_id"
        case userID = "user_id"
        case semesterID = "semester_id"
        case semesterDate = "semester_date"
        case nickname
        case isLiked = "is_liked"
        case rating, likes
        case assignmentAmount = "assignment_amount"
        case difficulty
        case gradePortion = "grade_portion"
        case attendanceFrequency = "attendance_frequency"
        case testTimes = "test_times"
        case comment
        case hashTags = "hash_tags"
        case assignment
        case returnID = "return_id"
        case isDeleted = "is_deleted"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
