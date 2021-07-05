//
//  CommonResponse.swift
//  hangang (iOS)
//
//  Created by 정태훈 on 2021/06/18.
//

import Foundation

struct CommonResponse<T: Codable>: Codable {
    let result: [T]?
    let count: Int

    enum CodingKeys: String, CodingKey {
        case result
        case count
    }
}
