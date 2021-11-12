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
    let semesters: [Semester] = [
        Semester(
                id: 1,
                semester: "2019년 1학기",
                startTime: "20190201",
                isRegular: 1
        ),
        Semester(
                id: 2,
                semester: "2019년 2학기",
                startTime: "20190801",
                isRegular: 1
        ),
        Semester(
                id: 3,
                semester: "2020년 1학기",
                startTime: "20200201",
                isRegular: 1
        ),
        Semester(
                id: 4,
                semester: "2020년 2학기",
                startTime: "20200801",
                isRegular: 1
        ),
        Semester(
                id: 5,
                semester: "2021년 1학기",
                startTime: "20210201",
                isRegular: 1
        ),
        Semester(
                id: 6,
                semester: "2021년 여름학기",
                startTime: "20210501",
                isRegular: 0
        ),
        Semester(
                id: 7,
                semester: "2021년 2학기",
                startTime: "20210801",
                isRegular: 1
        ),
        Semester(
                id: 8,
                semester: "2021년 겨울학기",
                startTime: "20211101",
                isRegular: 0
        ),
        Semester(
                id: 9,
                semester: "2022년 1학기",
                startTime: "20220201",
                isRegular: 1
        )
    ]
    let objectWillChange = ObservableObjectPublisher()
    //@Published var currentSemester: Semester? = nil
    @Published var query: String = ""

    @Published var department: String = "교양학부"

    @Published var samesterList: [Semester] = []
    @Published var updateLectureList: [TimeTableLecture] = [] {
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
    @Published var lectureResult: [TimeTableLecture] = [] {
        didSet {
            objectWillChange.send()
        }
    }
    @Published var timeTableLecture: [TimeTableLecture] = [] {
        didSet {
            objectWillChange.send()
        }
    }

    @Published var lecturePage: Int = 1
    @Published var isMax: Bool = false
    
    @Published var mainTimeTable: MainTimeTable? = nil {
        didSet {
            selectedTimeTable = mainTimeTable
        }
    }


    @Published var selectedTimeTable: MainTimeTable? = nil {
        didSet {
            timeTableLecture = selectedTimeTable?.lectureList ?? []
        }
    }

    @Published var changedTimeTable: MainTimeTable? = nil {
        didSet {
            selectedTimeTable = changedTimeTable
            loadTimeTables(semesterDateId: nil)
        }
    }

    @Published var timeTables: [TimeTable] = [] {
        didSet {
            objectWillChange.send()
        }
    }
    
    var timeTableHandler: TimeTableHandler = TimeTableHandler()
    
    private var disposables: Set<AnyCancellable> = []
    
    private var searchLecturePublisher: AnyPublisher<[TimeTableLecture], Never> {
        return timeTableHandler.$lectureResponse
                .receive(on: RunLoop.main)
                .map { $0 }
            .eraseToAnyPublisher()
        }

    private var lectureListPublisher: AnyPublisher<MainTimeTable?, Never> {
        return timeTableHandler.$mainTimeTableResponse
                .receive(on: RunLoop.main)
                .map { $0 }
                .eraseToAnyPublisher()
    }

    private var timeTablesPublisher: AnyPublisher<[TimeTable], Never> {
        return timeTableHandler.$timeTablesResponse
                .receive(on: RunLoop.main)
                .map { $0 }
                .eraseToAnyPublisher()
    }

    private var timeTablePublisher: AnyPublisher<MainTimeTable?, Never> {
        return timeTableHandler.$selectedTimeTableResponse
                .receive(on: RunLoop.main)
                .map { $0 }
                .eraseToAnyPublisher()
    }

    private var changedTimeTablePublisher: AnyPublisher<MainTimeTable?, Never> {
        return timeTableHandler.$changedTimeTableResponse
                .receive(on: RunLoop.main)
                .map { $0 }
                .eraseToAnyPublisher()
    }
    
    init() {

        searchLecturePublisher
                    .receive(on: RunLoop.main)
                    .assign(to: \.updateLectureList, on: self)
                    .store(in: &disposables)

        lectureListPublisher
                .receive(on: RunLoop.main)
                .assign(to: \.mainTimeTable, on: self)
                .store(in: &disposables)

        timeTablesPublisher
                .receive(on: RunLoop.main)
                .assign(to: \.timeTables, on: self)
                .store(in: &disposables)

        timeTablePublisher
                .receive(on: RunLoop.main)
                .assign(to: \.selectedTimeTable, on: self)
                .store(in: &disposables)

        changedTimeTablePublisher
                .receive(on: RunLoop.main)
                .assign(to: \.changedTimeTable, on: self)
                .store(in: &disposables)

        /*self.$timeTableLecture.map { t in
                    t.flatMap { lecture in
                        lecture.event
                    }
                }
                .receive(on: RunLoop.main)
                .assign(to: \.courseList, on: self)
                .store(in: &disposables)*/

        loadMain()
        search(query: "", department: "교양학부")
        loadTimeTables(semesterDateId: nil)
    }
    
    func search(query: String, department: String) {
        self.query = query
        self.department = department
        self.isMax = false
        self.lecturePage = 1
        
        timeTableHandler.search(
            department: department,
            page: lecturePage,
            semesterDateId: Int(self.selectedTimeTable?.tableSemesterDate ?? "7") ?? 7,
            keyword: query
        )
        
    }
    
    func fetch() {
        if(!isMax) {
            self.lecturePage = lecturePage + 1
            timeTableHandler.search(
                department: department,
                page: lecturePage,
                semesterDateId: Int(self.selectedTimeTable?.tableSemesterDate ?? "7") ?? 7,
                keyword: query
            )
        }
        
    }

    func loadMain() {
        timeTableHandler.getMainTimeTable()
    }

    func loadTimeTables(semesterDateId: Int?) {
        timeTableHandler.getTimeTables(semesterDateId: semesterDateId)
    }

    func setMainTimeTable() {
        timeTableHandler.setMainTimeTable(timeTable: selectedTimeTable!)
    }

    func changeMainTimeTableName(name: String) {
        timeTableHandler.changeTimeTable(timeTable: selectedTimeTable!, name: name)
    }

    func deleteMainTimeTable() {
        timeTableHandler.deleteTimeTable(
                timeTable: selectedTimeTable!,
        mainTimeTable: mainTimeTable!
        )
    }

    func getTimeTable(timeTableId: Int) {
        timeTableHandler.getTimeTable(timeTableId: timeTableId)
    }
    
    struct AddLectureParameter: Encodable {
        let lecture_timetable_id: Int
        let user_timetable_id: Int
    }
    
    func addLecture(lecture: TimeTableLecture) {
        let url: String = "https://api.hangang.in/timetable/lecture"
        let accessToken = UserDefaults.standard.string(forKey: "access_token")


        //print(self.selectedTimeTable!.id)

        AF.request(url,
                   method: .post,
                   parameters: AddLectureParameter(lecture_timetable_id: lecture.id, user_timetable_id: self.selectedTimeTable?.id ?? -1),
                encoder: JSONParameterEncoder.default,
                headers: [
                    .authorization("Bearer " + (accessToken ?? ""))
                   ]
        ).responseJSON() { response in

            switch response.result {
            case .success(let value):
                let json = JSON(value)

                var responseLecture: TimeTableLecture? = nil
                do {
                    let encoder: JSONEncoder = JSONEncoder()
                    encoder.outputFormatting = .prettyPrinted
                    let jsonData: Data = try encoder.encode(json)

                    let decoder: JSONDecoder = JSONDecoder()
                    responseLecture = try decoder.decode(TimeTableLecture.self, from: jsonData)
                } catch {

                }
                var selectedList = (self.selectedTimeTable?.lectureList ?? [])
                if(responseLecture != nil) {
                    selectedList.append(responseLecture!)
                }

                var changed: MainTimeTable = MainTimeTable(
                        id: self.selectedTimeTable!.id,
                        tableName: self.selectedTimeTable!.tableName,
                        tableSemesterDate: self.selectedTimeTable!.tableSemesterDate,
                        lectureList: selectedList
                )

                self.selectedTimeTable = changed
                break
            case .failure(let value):
                let json = JSON(value)

                break
            }

            
        }
    }

    func deleteLecture(lecture: TimeTableLecture) {
        let url: String = "https://api.hangang.in/timetable/lecture"
        let accessToken = UserDefaults.standard.string(forKey: "access_token")


        //print(self.selectedTimeTable!.id)

        AF.request(url,
                method: .delete,
                parameters: AddLectureParameter(lecture_timetable_id: lecture.id, user_timetable_id: self.selectedTimeTable!.id),
                encoder: JSONParameterEncoder.default,
                headers: [
                    .authorization("Bearer " + (accessToken ?? ""))
                ]
        ).responseJSON() { response in

            switch response.result {
            case .success(let value):
                let json = JSON(value)

                if(json["httpStatus"] == "OK") {
                    var selectedList = (self.selectedTimeTable?.lectureList ?? [])
                    selectedList.removeAll(where: { t in
                        return t == lecture
                    })

                    var changed: MainTimeTable = MainTimeTable(
                            id: self.selectedTimeTable!.id,
                            tableName: self.selectedTimeTable!.tableName,
                            tableSemesterDate: self.selectedTimeTable!.tableSemesterDate,
                            lectureList: selectedList
                    )

                    self.selectedTimeTable = changed
                }


                break
            case .failure(let value):
                let json = JSON(value)
                break
            }


        }
    }
    

    
}
