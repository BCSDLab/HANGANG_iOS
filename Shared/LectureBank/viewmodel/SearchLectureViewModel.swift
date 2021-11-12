//
//  SearchLectureViewModel.swift
//  hangang (iOS)
//
//  Created by 정태훈 on 2021/10/04.
//

import Foundation
import ElliotableSwiftUI
import Combine
import SwiftUI
import Alamofire
import SwiftyJSON

class SearchLectureViewModel: ObservableObject, Identifiable {

    let objectWillChange = ObservableObjectPublisher()
    //@Published var currentSemester: Semester? = nil
    @Published var query: String = ""
    @Published var department: String = "교양학부"

    @Published var updateLectureList: [Lecture] = [] {
        didSet {
            if(updateLectureList.isEmpty) {
                self.isMax = true
            }
            
            if(lecturePage == 1) {
                self.lectureResult = updateLectureList
            } else {
                self.lectureResult = lectureResult + updateLectureList
            }
            
        }
    }
    @Published var lectureResult: [Lecture] = [] {
        didSet {
            objectWillChange.send()
        }
    }

    @Published var lecturePage: Int = 1
    @Published var isMax: Bool = false
    
    var lectureHandler: LectureHandler = LectureHandler()
    
    private var disposables: Set<AnyCancellable> = []
    
    private var searchLecturePublisher: AnyPublisher<[Lecture], Never> {
        return lectureHandler.$lectureResponse
                .receive(on: RunLoop.main)
                .map { $0 }
            .eraseToAnyPublisher()
        }
    
    init(initQuery: String?) {
        searchLecturePublisher
                    .receive(on: RunLoop.main)
                    .assign(to: \.updateLectureList, on: self)
                    .store(in: &disposables)

        /*self.$timeTableLecture.map { t in
                    t.flatMap { lecture in
                        lecture.event
                    }
                }
                .receive(on: RunLoop.main)
                .assign(to: \.courseList, on: self)
                .store(in: &disposables)*/

        search(query: initQuery ?? "", department: "교양학부")
    }
    
    func search(query: String, department: String) {
        self.query = query
        self.department = department
        self.isMax = false
        self.lecturePage = 1
        
        lectureHandler.search(
            page: lecturePage,
            department: department,
            keyword: query
        )
        
    }
    
    func fetch() {
        if(!isMax) {
            self.lecturePage = lecturePage + 1
            lectureHandler.search(
                page: lecturePage,
                department: department,
                keyword: query
            )
        }
        
    }
    

    
}

