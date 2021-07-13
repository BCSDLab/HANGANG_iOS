//
//  TimeTableViewModel.swift
//  hangang (iOS)
//
//  Created by 정태훈 on 2021/03/28.
//

import Foundation
import ElliotableSwiftUI
import Combine
import SwiftUI
import Alamofire
import SwiftyJSON

class TimeTableViewModel: ObservableObject, Identifiable {
    @Published var query: String = ""
    @Published var department: String = ""
    var token: Token?
    
    
    @Published var lectureResult: [TimeTableLecture] = []
    @Published var lecturePage: Int = 1
    
    @Published var mainTimeTable: MainTimeTable? = nil
    
    var timeTableHandler: TimeTableHandler = TimeTableHandler()
    
    private var disposables: Set<AnyCancellable> = []
    
    private var searchLecturePublisher: AnyPublisher<[TimeTableLecture], Never> {
        return timeTableHandler.$lectureResponse
                .receive(on: RunLoop.main)
                .map { $0 }
            .eraseToAnyPublisher()
        }
    
    
    init(token: Token?) {
        self.token = token
        
        searchLecturePublisher
                    .receive(on: RunLoop.main)
                    .assign(to: \.lectureResult, on: self)
                    .store(in: &disposables)
        search()
    }
    
    func search() {
        timeTableHandler.search(
            page: 1,
            token: self.token,
            keyword: query
        )
        
    }
    
    func loadMainTable(completionHandler: @escaping (_ result: MainTimeTable?) -> ()) {
        let url: String = "https://api.hangang.in/timetable/main/lecture"
        
        AF.request(url,
                   method: .get,
                   headers: [
                    .authorization("Bearer " + (token?.access_token ?? ""))
                   ]
        ).validate().responseDecodable { (response: DataResponse<MainTimeTable, AFError>) in
            switch response.result {
            case .success:
                completionHandler(response.value)
            case .failure:
                completionHandler(nil)
            }
            
        }
    }
    /*
     {
         "message": "강의가 정상적으로 추가되었습니다",
         "httpStatus": "OK"
     }
     */
    
    struct AddLectureParameter: Encodable {
        let lecture_id: Int
        let user_timetable_id: Int
    }
    
    func addLecture(lectureId: Int) {
        let url: String = "https://api.hangang.in/timetable/lecture"
        
        AF.request(url,
                   method: .post,
                   parameters: AddLectureParameter(lecture_id: lectureId, user_timetable_id: 93),
                   encoder: JSONParameterEncoder.default,
                   headers: [
                    .authorization("Bearer " + (token?.access_token ?? ""))
                   ]
        ).validate().responseJSON() { response in
            
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print(json)
                
                self.loadMainTable() { result in
                    self.mainTimeTable = result
                }
                break
            case .failure(let value):
                let json = JSON(value)
                print(json)
                self.mainTimeTable = nil
                break
            }
            
        }
    }
    

    
}
