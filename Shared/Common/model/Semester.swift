//
// Created by 정태훈 on 2021/07/09.
//

import Foundation

struct Semester: Identifiable, Hashable {
    let id: Int
    let semester: String
    let startTime: Date
    let isRegular: Bool

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: Semester, rhs: Semester) -> Bool {
        return lhs.id == rhs.id
    }
}