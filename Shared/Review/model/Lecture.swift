//
//  Lecture.swift
//  hangang (iOS)
//
//  Created by 정태훈 on 2021/02/08.
//

import Foundation

// MARK: - Lecture
struct Lecture: Codable, Hashable {
    let id: Int?
    var isScraped: Bool?
    let grade: Int?
    let semesterData: [String]?
    let top3HashTag: [HashTag]?
    let department,code: String?
    let name, professor: String
    let classification: String?
    let totalRating: Double?
    let lastReviewedAt: String?
    let reviewCount: Int?
    let isDeleted: Bool?
    let createdAt, updatedAt: String?

    init(id: Int?, isScraped: Bool?,grade: Int?, semesterData: [String]?, top3HashTag: [HashTag]?, department: String?, code: String?, name: String, professor: String, classification: String?, totalRating: Double?, lastReviewedAt: String?, reviewCount: Int?, isDeleted: Bool?, createdAt: String?, updatedAt: String?) {
        self.id = id
        self.isScraped = isScraped
        self.grade = grade
        self.semesterData = semesterData
        self.top3HashTag = top3HashTag
        self.department = department
        self.code = code
        self.name = name
        self.professor = professor
        self.classification = classification
        self.totalRating = totalRating
        self.lastReviewedAt = lastReviewedAt
        self.reviewCount = reviewCount
        self.isDeleted = isDeleted
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }

    enum CodingKeys: String, CodingKey {
        case id
        case isScraped = "is_scraped"
        case semesterData = "semester_data"
        case top3HashTag = "top3_hash_tag"
        case code, grade, name, department, professor, classification
        case totalRating = "total_rating"
        case lastReviewedAt = "last_reviewed_at"
        case reviewCount = "review_count"
        case isDeleted = "is_deleted"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
    
    func hash(into hasher: inout Hasher) {
           hasher.combine(id)
        }
    
    static func == (lhs: Lecture, rhs: Lecture) -> Bool {
        return lhs.id == rhs.id
    }
}

// MARK: - Top3HashTag
struct HashTag: Codable, Identifiable, Hashable {
    let id: Int
    let tag: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case tag
    }
    
    func hash(into hasher: inout Hasher) {
           hasher.combine(id)
        }
    
    static func == (lhs: HashTag, rhs: HashTag) -> Bool {
        return lhs.id == rhs.id
    }
}
