//
//  HangangResponse.swift
//  hangang (iOS)
//
//  Created by 정태훈 on 2021/01/01.
//

import Foundation

class TokenLoginResponse: Decodable {
    var url: String?
    
    enum CodingKeys: String, CodingKey {
        case url
    }
    
    init() {}
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        url = try? container.decode(String.self, forKey: .url)
    }
}
