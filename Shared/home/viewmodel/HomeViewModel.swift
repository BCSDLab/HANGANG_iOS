//
//  HomeViewModel.swift
//  hangang (iOS)
//
//  Created by 정태훈 on 2021/01/01.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject, Identifiable {
    @Published var query: String = ""
    @Published var department: String = "교양학부" {
        didSet{
            search()
        }
    }
    @Published var page: Int = 1
    
    @Published var lectureResult: [Lecture] = []
    @Published var hitLectureBank: [LectureBank] = []
    @Published var timeTableLectureResult: [TimeTableLecture] = []
    /*@Published var mainTimeTable: MainTimeTable? = nil {
        didSet {
            selectedTimeTable = mainTimeTable
            timeTableLecture = mainTimeTable?.lectureList ?? []
        }
    }*/
    
    var lectureHandler: LectureHandler = LectureHandler()
    var timeTableHandler: TimeTableHandler = TimeTableHandler()
    var lectureBankHandler: LectureBankHandler = LectureBankHandler()
    
    private var disposables: Set<AnyCancellable> = []
    
    private var searchLecturePublisher: AnyPublisher<[Lecture], Never> {
        lectureHandler.$lectureResponse
                .receive(on: RunLoop.main)
                .map { $0 }
            .eraseToAnyPublisher()
        }

    private var timeTablePublisher: AnyPublisher<[TimeTableLecture], Never> {
        timeTableHandler.$timeTableLectureResponse
                .receive(on: RunLoop.main)
                .map { $0 }
                .eraseToAnyPublisher()
    }

    private var hitLectureBankPublisher: AnyPublisher<[LectureBank], Never> {
        lectureBankHandler.$hitLectureBankResponse
                .receive(on: RunLoop.main)
                .map { $0 }
                .eraseToAnyPublisher()
    }
    
    init() {
        searchLecturePublisher
                    .receive(on: RunLoop.main)
                    .assign(to: \.lectureResult, on: self)
                    .store(in: &disposables)
        timeTablePublisher
                .receive(on: RunLoop.main)
                .assign(to: \.timeTableLectureResult, on: self)
                .store(in: &disposables)
        hitLectureBankPublisher
                .receive(on: RunLoop.main)
                .assign(to: \.hitLectureBank, on: self)
                .store(in: &disposables)
        search()
        timeTableHandler.getMainTimeTableLecture()
        lectureBankHandler.getHitLectureBank()
    }
    
    func search() {
        lectureHandler.getLectureRank(
            page: page,
            sort: "평점순",
            department: department,
        query: ""
        )


    }
    
}
