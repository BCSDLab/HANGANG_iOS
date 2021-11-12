//
//  Review.swift
//  hangang (iOS)
//
//  Created by 정태훈 on 2021/05/16.
//

import Foundation

// MARK: - Review
struct Review: Codable, Identifiable, Hashable {
    let id, lectureID, userID: Int
    let semesterID: Int?
    let semesterDate, nickname: String
    var isLiked: Bool
    let rating: Double
    var likes: Int
    let assignmentAmount, difficulty, gradePortion: Int
    let attendanceFrequency: Int
    let testTimes: Int?
    let comment: String
    let hashTags: [HashTag]
    let assignment: [Assignment]
    let returnID: Int?
    let isDeleted: Bool
    let createdAt, updatedAt: String

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
    
    func hash(into hasher: inout Hasher) {
           hasher.combine(id)
        }
    
    static func == (lhs: Review, rhs: Review) -> Bool {
        return lhs.id == rhs.id
    }
    
}

// MARK: - Assignment
struct Assignment: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
    
    func hash(into hasher: inout Hasher) {
           hasher.combine(id)
        }
    
    static func == (lhs: Assignment, rhs: Assignment) -> Bool {
        return lhs.id == rhs.id
    }
}
