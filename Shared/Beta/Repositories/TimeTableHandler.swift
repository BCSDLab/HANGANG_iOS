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
    let department: String?
    let hashtag: [Int]?
    
    let limit: Int = 10
    let sort: String = ""*/
    let keyword: String?
    let semesterDateId = 5
    let page: Int
}

class TimeTableHandler: APIHandler {
    @Published var lectureResponse: [TimeTableLecture] = []
    //@Published var timeTableLectureResponse: MainTimeTable? = nil
    
    func search(page: Int, token: Token, keyword: String)  {
        let url: String = "https://api.hangang.in/timetable/lecture/list"
        
        let data: TimeTableLectureRequest = TimeTableLectureRequest(
            keyword: keyword.isEmpty ? nil : keyword,
            page: page
            )
        
        
        AF.request(url,
                   method: .get,
                   parameters: data,
                   encoder: URLEncodedFormParameterEncoder.default,
                   headers: [
                    .authorization("Bearer " + token.access_token),
                    HTTPHeader(
                    name: "RefreshToken", value: "Bearer " + token.refresh_token)
                   ]
        ).responseDecodable { [weak self] (response: DataResponse<[TimeTableLecture], AFError>) in
            guard let weakSelf = self else { return }
            guard let response = weakSelf.handleResponse(response) as? [TimeTableLecture] else {
                            return
                        }
            weakSelf.lectureResponse = response
        }
    }
    
    /*func getMainTimeTable(token: Token) {
        let url: String = "https://api.hangang.in/timetable/main/lecture"
        
        AF.request(url,
                   parameters: ["":""],
                   encoder: URLEncodedFormParameterEncoder.default,
                   headers: [
                    .authorization("Bearer " + token.access_token),
     HTTPHeader(
     name: "RefreshToken", value: "Bearer " + token.refresh_token)
                   ]
        ).responseDecodable { [weak self] (response: DataResponse<MainTimeTable, AFError>) in
            guard let weakSelf = self else { return }
            guard let response = weakSelf.handleResponse(response) as? MainTimeTable else {
                            return
                        }
            weakSelf.timeTableLectureResponse = response
        }
    }*/
    
}
