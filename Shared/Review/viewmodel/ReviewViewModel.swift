//
//  ReviewViewModel.swift
//  hangang (iOS)
//
//  Created by 정태훈 on 2021/05/30.
//

import Foundation
import Combine

class ReviewViewModel: ObservableObject, Identifiable {
    @Published var query: String = ""
    @Published var department: String = "교양학부" {
        didSet{
            search(query: query)
        }
    }

    @Published var sort: String = "평점순" {
        didSet{
            search(query: query)
        }
    }

    @Published var types: [String] = [] {
        didSet{
            search(query: query)
        }
    }

    @Published var hashTags: [Int] = [] {
        didSet{
            search(query: query)
        }
    }

    @Published var page: Int = 1
    @Published var isLoading: Bool = false
    @Published var isMax: Bool = false

    @Published var lectureResult: [Lecture] = []

    @Published var updateLectureResult: [Lecture] = [] {
        didSet {
            if(updateLectureResult.isEmpty) {
                isMax = true
            } else {
                self.lectureResult = lectureResult + updateLectureResult
            }
        }
    }

    var lectureHandler: LectureHandler = LectureHandler()

    private var disposables: Set<AnyCancellable> = []

    private var loadingPublisher: AnyPublisher<Bool, Never> {
        lectureHandler.$isLoading
                .receive(on: RunLoop.main)
                .map { $0 }
                .eraseToAnyPublisher()
    }

    private var searchLecturePublisher: AnyPublisher<[Lecture], Never> {
        lectureHandler.$lectureResponse
                .receive(on: RunLoop.main)
                .map { $0 }
                .eraseToAnyPublisher()
    }


    init(major: String?) {
        if(major != nil) {
            department = major!
        }
        searchLecturePublisher
                .receive(on: RunLoop.main)
                .assign(to: \.updateLectureResult, on: self)
                .store(in: &disposables)
        loadingPublisher
                .receive(on: RunLoop.main)
                .assign(to: \.isLoading, on: self)
                .store(in: &disposables)
        search(query: "")
    }

    func search(query: String) {
        self.query = query
        isMax = false
        page = 1
        lectureResult = []
        lectureHandler.getLectureRank(
                page: page,
                sort: "평점순",
                department: department,
                query: query
        )
    }

    func fetch() {
        print("fetch")
        if(!isMax) {
            page = page + 1
            lectureHandler.getLectureRank(
                    page: page,
                    sort: "평점순",
                    department: department,
                    query: self.query
            )
        }
    }

    func reset() {
        department = "교양학부"
        sort = "평점순"
        types = []
        hashTags = []
        page = 1
        isMax = false
    }

}
