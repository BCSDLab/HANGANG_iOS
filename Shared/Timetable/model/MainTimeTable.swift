//
//  MainTimeTable.swift
//  hangang (iOS)
//
//  Created by 정태훈 on 2021/04/26.
//

import Foundation

struct MainTimeTable: Codable {
    let id: Int
    let tableName, tableSemesterDate: String
    let lectureList: [TimeTableLecture]
}
