//
//  TimeTableLecture.swift
//  hangang (iOS)
//
//  Created by 정태훈 on 2021/03/28.
import ElliotableSwiftUI
import SwiftUI

let timeTableColors: [UIColor?] = [
    UIColor(named: "timeBlue"),
    UIColor(named: "timeGreen"),
    UIColor(named: "timeMint"),
    UIColor(named: "timeOrange"),
    UIColor(named: "timePink"),
    UIColor(named: "timeRed"),
    UIColor(named: "timeViolet")
]

let timeData: Dictionary<Int, String> = [
    0: "09:00",
    1: "09:30",
    2: "10:00",
    3: "10:30",
    4: "11:00",
    5: "11:30",
    6: "12:00",
    7: "12:30",
    8: "13:00",
    9: "13:30",
    10: "14:00",
    11: "14:30",
    12: "15:00",
    13: "15:30",
    14: "16:00",
    15: "16:30",
    16: "17:00",
    17: "17:30",
    18: "18:00",
    19: "18:30",
    20: "19:00",
    21: "19:30",
    22: "20:00",
    23: "20:30",
    24: "21:00",
    25: "21:30",
    26: "22:00",
    27: "22:30",
    28: "23:00"
]

struct TimeTableLecture: Codable, Hashable {
    let id, lectureID: Int
    let lectureTimetableID: Int?
    let isScraped, isCustom: Bool
    let userTimetableID: JSONNull?
    let semesterDate, code, name, classification: String
    let grades, classNumber, regularNumber, department: String
    let target, professor: String
    let isEnglish, designScore, isElearning: String?
    let classTime, createdAt, updatedAt: String
    let rating: Double
    let memo: String?
    let isReviewed: Bool
    
    enum CodingKeys: String, CodingKey {
            case id
            case lectureID = "lecture_id"
            case lectureTimetableID = "lecture_timetable_id"
            case isScraped = "is_scraped"
            case isCustom = "is_custom"
            case userTimetableID = "user_timetable_id"
            case semesterDate = "semester_date"
            case code, name, classification, grades, classNumber
            case regularNumber = "regular_number"
            case department, target, professor
            case isEnglish = "is_english"
            case designScore = "design_score"
            case isElearning = "is_elearning"
            case classTime = "class_time"
            case createdAt = "created_at"
            case updatedAt = "updated_at"
            case rating, memo
            case isReviewed = "is_reviewed"
        }

    func hash(into hasher: inout Hasher) {
           hasher.combine(id)
        }
    
    static func == (lhs: TimeTableLecture, rhs: TimeTableLecture) -> Bool {
        return lhs.code == rhs.code && lhs.classNumber == rhs.classNumber && lhs.semesterDate == rhs.semesterDate
        //return lhs.lectureID == rhs.lectureID
    }

    func toLecture() -> Lecture {
        return Lecture(
               id: lectureID,
                isScraped: nil,
                grade: Int(grades),
                semesterData: [],
                top3HashTag: [],
                department: department,
                code: code,
                name: name,
                professor: professor,
                classification: classification,
                totalRating: rating,
                lastReviewedAt: nil,
                reviewCount: 0,
                isDeleted: false,
                createdAt: createdAt,
                updatedAt: updatedAt
        )
    }

    func toTimeTableLectureInfo() -> TimeTableLectureInfo {
        return TimeTableLectureInfo(
                id: id,
                name: name,
                classNumber: classNumber,
                target: target,
                professor: professor,
                classTime: classTime,
                selectedTableId: []
        )
    }
    
    var classTimeList: Array<TimeDuration> {
        let jsonData = self.classTime.data(using: .utf8)!

        let decoder = JSONDecoder()

        let list = try! decoder.decode([Int].self, from: jsonData)

        var center: Array<Int> = []
        var result: Array<TimeDuration> = []

        if(!list.isEmpty) {
            center.append(list[0])
            for i in 1..<list.count-1 {
                if(list[i] + 1 == list[i+1] && list[i-1] + 1 == list[i]) {
                    continue
                } else if(list[i-1] + 1 != list[i] && list[i] + 1 == list[i+1]){
                    center.append(list[i])
                } else if(list[i-1] + 1 == list[i] && list[i] + 1 != list[i+1]) {
                    center.append(list[i])
                } else {
                    continue
                }
            }
            center.append(list[list.count - 1])
            for i in stride(from: 0, to: center.count, by: 2) {
                result.append(TimeDuration(start: center[i], end: center[i+1]))
            }
        }



        return result
    }
    
    var classTimeString: String {
        var list: Array<String> = []
        
        let date: Dictionary<Int, String> = [
            0: "월",
            1: "화",
            2: "수",
            3: "목",
            4: "금",
            5: "토",
            6: "일",
        ]
        
        classTimeList.forEach { duration in
            list.append("\(date[duration.start / 100] ?? "") \(((duration.start % 100) / 2) + 1)\(String(format: "%c", (duration.start % 2)+65))~\(((duration.end % 100) / 2) + 1)\(String(format: "%c", (duration.end % 2)+65))")
        }

        return list.joined(separator: " ")
    }
    
    var event: [ElliottEvent] {
        var list: Array<ElliottEvent> = []
        
        classTimeList.forEach { duration in
            list.append(ElliottEvent(courseId: String(id), courseName: name, courseNum: classNumber, roomName: "", professor: professor, courseDay: ElliotDay(rawValue: (duration.start / 100) + 1) ?? .monday, startTime: timeData[duration.start % 100] ?? "09:00", endTime: timeData[(duration.end % 100) + 1] ?? "09:00", backgroundColor: (timeTableColors[id % 7] ?? UIColor(named: "timeBlue"))!))
        }
        return list
    }
}

struct TimeTableLectureInfo: Codable, Hashable {
    let id: Int
    let name: String
    let classNumber: String
    let target, professor: String
    let classTime: String
    let selectedTableId: [Int]

    enum CodingKeys: String, CodingKey {
        case id
        case name, classNumber
        case target, professor
        case selectedTableId
        case classTime = "classTime"
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: TimeTableLectureInfo, rhs: TimeTableLectureInfo) -> Bool {
        return lhs.id == rhs.id
        //return lhs.lectureID == rhs.lectureID
    }

    var classTimeList: Array<TimeDuration> {
        let jsonData = self.classTime.data(using: .utf8)!

        let decoder = JSONDecoder()

        let list = try! decoder.decode([Int].self, from: jsonData)

        var center: Array<Int> = []
        var result: Array<TimeDuration> = []

        if(!list.isEmpty) {
            center.append(list[0])
            for i in 1..<list.count-1 {
                if(list[i] + 1 == list[i+1] && list[i-1] + 1 == list[i]) {
                    continue
                } else if(list[i-1] + 1 != list[i] && list[i] + 1 == list[i+1]){
                    center.append(list[i])
                } else if(list[i-1] + 1 == list[i] && list[i] + 1 != list[i+1]) {
                    center.append(list[i])
                } else {
                    continue
                }
            }
            center.append(list[list.count - 1])
            for i in stride(from: 0, to: center.count, by: 2) {
                result.append(TimeDuration(start: center[i], end: center[i+1]))
            }
        }



        return result
    }

    var classTimeString: String {
        var list: Array<String> = []

        let date: Dictionary<Int, String> = [
            0: "월",
            1: "화",
            2: "수",
            3: "목",
            4: "금",
            5: "토",
            6: "일",
        ]

        classTimeList.forEach { duration in
            list.append("\(date[duration.start / 100] ?? "") \(((duration.start % 100) / 2) + 1)\(String(format: "%c", (duration.start % 2)+65))~\(((duration.end % 100) / 2) + 1)\(String(format: "%c", (duration.end % 2)+65))")
        }

        return list.joined(separator: " ")
    }
}

struct TimeDuration: Hashable {
    let start: Int
    let end: Int
    
    static func == (lhs: TimeDuration, rhs: TimeDuration) -> Bool {
        return lhs.start == rhs.start
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.start)
    }
}
