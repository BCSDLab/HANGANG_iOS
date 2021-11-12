//
// Created by 정태훈 on 2021/07/09.
//

import Foundation

struct Semester: Identifiable, Hashable, Codable {
    let id: Int
    let semester, startTime: String
    let isRegular: Int

    enum CodingKeys: String, CodingKey {
        case id, semester
        case startTime = "start_time"
        case isRegular = "is_regular"
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: Semester, rhs: Semester) -> Bool {
        return lhs.id == rhs.id
    }
}