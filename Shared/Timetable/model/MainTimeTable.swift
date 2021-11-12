//
//  MainTimeTable.swift
//  hangang (iOS)
//
//  Created by 정태훈 on 2021/04/26.
//

import Foundation

struct MainTimeTable: Codable, Hashable, Identifiable {
    let id: Int
    let tableName, tableSemesterDate: String
    let lectureList: [TimeTableLecture]

    func getTimeTable() -> TimeTable {
        return TimeTable(
                id: id,
                semesterDateID: Int(tableSemesterDate) ?? 0,
                name: tableName,
                isDeleted: false
        )
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: MainTimeTable, rhs: MainTimeTable) -> Bool {
        return lhs.id == rhs.id
    }
}

struct TimeTable: Codable, Hashable, Identifiable {
    let id: Int
    let semesterDateID: Int
    let name: String
    let isDeleted: Bool

    enum CodingKeys: String, CodingKey {
        case id
        case semesterDateID = "semester_date_id"
        case name
        case isDeleted = "is_deleted"
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: TimeTable, rhs: TimeTable) -> Bool {
        return lhs.id == rhs.id
    }
}
