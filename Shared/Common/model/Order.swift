//
//  Order.swift
//  hangang (iOS)
//
//  Created by 정태훈 on 2021/07/04.
//

import Foundation

struct Order: Codable, Identifiable, Hashable {
    let id: String
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
    
    func hash(into hasher: inout Hasher) {
           hasher.combine(id)
        }
    
    static func == (lhs: Order, rhs: Order) -> Bool {
        return lhs.id == rhs.id
    }
}
