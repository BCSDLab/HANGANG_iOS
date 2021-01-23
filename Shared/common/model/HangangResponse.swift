//
//  HangangResponse.swift
//  hangang (iOS)
//
//  Created by 정태훈 on 2021/01/23.
//

class HangangResponse: Decodable {
    let message: String?
    let httpStatus: String?
    
    init() {
        message = nil
        httpStatus = nil
    }
}
