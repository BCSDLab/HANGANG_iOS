//
//  LectureBank.swift
//  hangang (iOS)
//
//  Created by 정태훈 on 2021/02/21.
//

import Foundation

// MARK: - LectureBank
struct LectureBank: Codable, Hashable {
    let id, userID, lectureID: Int
    let category: [String]
    let title, content: String
    let pointPrice: Int
    let semesterDate: String
    let uploadFiles: [UploadFile]?
    let hits: Int
    let createdAt, updatedAt: String
    let isDeleted, isHit: Bool
    let userScrapID: Int
    let isPurchase: Bool
    let thumbnail: String
    let user: UserNickname
    let lecture: Lecture

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case lectureID = "lecture_id"
        case category, title, content
        case pointPrice = "point_price"
        case semesterDate = "semester_date"
        case uploadFiles, hits
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case isDeleted = "is_deleted"
        case isHit = "is_hit"
        case userScrapID = "user_scrap_id"
        case isPurchase = "is_purchase"
        case thumbnail, user, lecture
    }
    
    func hash(into hasher: inout Hasher) {
           hasher.combine(id)
        }
    
    static func == (lhs: LectureBank, rhs: LectureBank) -> Bool {
        return lhs.id == rhs.id
    }


    
}

struct ScrapLectureBank: Codable, Hashable {
    let scrapId, id, userID, lectureID: Int
    let category: [String]
    let title, content: String
    let pointPrice: Int
    let semesterDate: String
    let hits: Int
    let scrapedAt, createdAt, updatedAt: String
    let isDeleted, isHit: Bool
    let thumbnail: String
    let user: UserNickname
    let lecture: Lecture

    enum CodingKeys: String, CodingKey {
        case scrapId = "scrap_id"
        case id
        case userID = "user_id"
        case lectureID = "lecture_id"
        case category, title, content
        case pointPrice = "point_price"
        case scrapedAt = "scraped_at"
        case semesterDate = "semester_date"
        case hits
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case isDeleted = "is_deleted"
        case isHit = "is_hit"
        case thumbnail, user, lecture
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(scrapId)
    }

    static func == (lhs: ScrapLectureBank, rhs: ScrapLectureBank) -> Bool {
        return lhs.scrapId == rhs.scrapId
    }

}
