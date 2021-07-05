//
//  User.swift
//  hangang (iOS)
//
//  Created by 정태훈 on 2021/01/31.
//

import Foundation

struct User: Codable {
    let id: Int
    let portalAccount: String
    let nickname: String
    let name: String?
    let major: [String]
    //let salt, role: JSONNull?
    //let authorityList: [JSONAny]
    //let profileImageURL: JSONNull?
    let point: Int
    let isDeleted: Bool
    let createdAt, updatedAt: String
    //let name: JSONNull?

    enum CodingKeys: String, CodingKey {
        case id
        case portalAccount = "portal_account"
        case /*password, */nickname, major/*, salt, role*///, authorityList
        //case profileImageURL = "profile_image_url"
        case point
        case name
        case isDeleted = "is_deleted"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        //case name
    }
}
