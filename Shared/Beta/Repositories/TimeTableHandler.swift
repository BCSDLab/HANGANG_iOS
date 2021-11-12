//
//  TimeTableHandler.swift
//  hangang (iOS)
//
//  Created by 정태훈 on 2021/03/28.
//

import Foundation
import Combine
import Alamofire
import SwiftyJSON

struct TimeTableLectureRequest: Encodable {
    /*let classification: [String]?
    
    let hashtag: [Int]?
    
    let limit: Int = 10
    let sort: String = ""*/
    let department: String?
    let keyword: String?
    let semesterDateId: Int
    let page: Int
}

struct TimeTablesRequest: Encodable {
    let semesterDateId: Int?
}

struct TimeTableRequest: Encodable {
    let timeTableId: Int
}


class TimeTableHandler: APIHandler {
    @Published var lectureResponse: [TimeTableLecture] = []
    @Published var mainTimeTableResponse: MainTimeTable? = nil
    @Published var timeTablesResponse: [TimeTable] = []
    @Published var currentSemester: Semester? = nil
    @Published var selectedTimeTableResponse: MainTimeTable? = nil
    @Published var changedTimeTableResponse: MainTimeTable? = nil
    @Published var timeTableLectureResponse: [TimeTableLecture] = []
    
    func search(department: String?, page: Int, semesterDateId: Int, keyword: String?)  {
        let url: String = "https://api.hangang.in/timetable/lecture/list"
        
        let accessToken = UserDefaults.standard.string(forKey: "access_token")
        
        let data: TimeTableLectureRequest = TimeTableLectureRequest(
            department: department,
            keyword: keyword,
            semesterDateId: semesterDateId,
            page: page
            )
        
        
        AF.request(url,
                   method: .get,
                   parameters: data,
                   encoder: URLEncodedFormParameterEncoder.default,
                   headers: [
                    .authorization("Bearer " + (accessToken ?? ""))
                   ]
        ).responseDecodable { [weak self] (response: DataResponse<CommonResponse<TimeTableLecture>, AFError>) in
            guard let weakSelf = self else { return }
            guard let response = weakSelf.handleResponse(response) as? CommonResponse<TimeTableLecture> else {
                            return
                        }
            print(response.result ?? [])
            weakSelf.lectureResponse = response.result ?? []
        }
    }
    
    func getMainTimeTable() {
        let url: String = "https://api.hangang.in/timetable/main/lecture"
        let accessToken = UserDefaults.standard.string(forKey: "access_token")
        AF.request(url,
                method: .get,
                   headers: [
                       .authorization("Bearer " + (accessToken ?? ""))
                   ]
        ).responseDecodable { [weak self] (response: DataResponse<MainTimeTable, AFError>) in
            guard let weakSelf = self else { return }
            guard let response = weakSelf.handleResponse(response) as? MainTimeTable else {
                            return
                        }
            weakSelf.mainTimeTableResponse = response
        }
    }

    func setMainTimeTable(timeTable: MainTimeTable) {
        let url: String = "https://api.hangang.in/timetable/main/lecture"
        let accessToken = UserDefaults.standard.string(forKey: "access_token")
        AF.request(url,
                method: .patch,
                parameters: timeTable,
                encoder: JSONParameterEncoder.default,
                headers: [
                    .authorization("Bearer " + (accessToken ?? ""))
                ]
        ).responseDecodable { [weak self] (response: DataResponse<MainTimeTable, AFError>) in
            guard let weakSelf = self else { return }
            guard let response = weakSelf.handleResponse(response) as? MainTimeTable else {
                return
            }
            weakSelf.mainTimeTableResponse = response
        }
    }

    func changeTimeTable(timeTable: MainTimeTable, name: String) {
        var changeTimeTable = TimeTable(
        id: timeTable.id,
        semesterDateID: (Int(timeTable.tableSemesterDate ?? "") ?? -1),
        name: name,
        isDeleted: false
        )

        let url: String = "https://api.hangang.in/timetable"
        let accessToken = UserDefaults.standard.string(forKey: "access_token")
        AF.request(url,
                method: .patch,
                parameters: changeTimeTable,
                encoder: JSONParameterEncoder.default,
                headers: [
                    .authorization("Bearer " + (accessToken ?? ""))
                ]
        ).responseDecodable { [weak self] (response: DataResponse<MainTimeTable, AFError>) in
            guard let weakSelf = self else { return }
            guard let response = weakSelf.handleResponse(response) as? MainTimeTable else {
                return
            }
            weakSelf.changedTimeTableResponse = response
        }
    }

    func deleteTimeTable(timeTable: MainTimeTable, mainTimeTable: MainTimeTable) {
        var changeTimeTable = TimeTable(
                id: timeTable.id,
                semesterDateID: (Int(timeTable.tableSemesterDate ?? "") ?? -1),
                name: timeTable.tableName,
                isDeleted: false
        )

        let url: String = "https://api.hangang.in/timetable"
        let accessToken = UserDefaults.standard.string(forKey: "access_token")
        AF.request(url,
                method: .delete,
                parameters: changeTimeTable,
                encoder: JSONParameterEncoder.default,
                headers: [
                    .authorization("Bearer " + (accessToken ?? ""))
                ]
        ).responseDecodable { [weak self] (response: DataResponse<MainTimeTable, AFError>) in
            guard let weakSelf = self else { return }
            guard let response = weakSelf.handleResponse(response) as? MainTimeTable else {
                return
            }
            weakSelf.changedTimeTableResponse = mainTimeTable
        }
    }

    func getMainTimeTableLecture() {
        let url: String = "https://api.hangang.in/timetable/main/lecture"
        let accessToken = UserDefaults.standard.string(forKey: "access_token")
        AF.request(url,
                method: .get,
                headers: [
                    .authorization("Bearer " + (accessToken ?? ""))
                ]
        ).responseDecodable { [weak self] (response: DataResponse<MainTimeTable, AFError>) in
            guard let weakSelf = self else { return }
            guard let response = weakSelf.handleResponse(response) as? MainTimeTable else {
                return
            }
            weakSelf.timeTableLectureResponse = response.lectureList
        }
    }

    func getCurrentSemester() {
        let url: String = "https://api.hangang.in/semester"
        AF.request(url,
                method: .get
        ).responseDecodable { [weak self] (response: DataResponse<Semester, AFError>) in
            guard let weakSelf = self else { return }
            guard let response = weakSelf.handleResponse(response) as? Semester else {
                return
            }
            weakSelf.currentSemester = response
        }
    }

    func getTimeTables(semesterDateId: Int?) {
        let url: String = "https://api.hangang.in/timetable"
        let accessToken = UserDefaults.standard.string(forKey: "access_token")
        var data: TimeTablesRequest? = nil

        if(semesterDateId != nil){
            data = TimeTablesRequest(
                    semesterDateId: semesterDateId
            )
        }

        AF.request(url,
                method: .get,
                parameters: data,
                encoder: URLEncodedFormParameterEncoder.default,
                headers: [
                    .authorization("Bearer " + (accessToken ?? ""))
                ]
        ).responseDecodable { [weak self] (response: DataResponse<[TimeTable], AFError>) in
            guard let weakSelf = self else { return }
            guard let response = weakSelf.handleResponse(response) as? [TimeTable] else {
                return
            }
            weakSelf.timeTablesResponse = response
        }
    }

    func getTimeTable(timeTableId: Int) {
        let url: String = "https://api.hangang.in/timetable/lecture"
        let accessToken = UserDefaults.standard.string(forKey: "access_token")
        var data: TimeTableRequest = TimeTableRequest(
                timeTableId: timeTableId
        )
        AF.request(url,
                method: .get,
                parameters: data,
                headers: [
                    .authorization("Bearer " + (accessToken ?? ""))
                ]
        ).responseDecodable { [weak self] (response: DataResponse<MainTimeTable, AFError>) in
            guard let weakSelf = self else { return }
            guard let response = weakSelf.handleResponse(response) as? MainTimeTable else {
                return
            }
            weakSelf.selectedTimeTableResponse = response
        }
    }
    
}
