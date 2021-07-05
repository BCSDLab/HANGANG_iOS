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
            search()
        }
    }
    
    @Published var sort: String = "평점순" {
        didSet{
            search()
        }
    }
    
    @Published var types: [String] = [] {
        didSet{
            search()
        }
    }
    
    @Published var hashTags: [Int] = [] {
        didSet{
            search()
        }
    }
    
    @Published var page: Int = 1
    
    @Published var lectureResult: [Lecture] = []
    
    var lectureHandler: LectureHandler = LectureHandler()
    
    private var disposables: Set<AnyCancellable> = []
    
    private var searchLecturePublisher: AnyPublisher<[Lecture], Never> {
        lectureHandler.$lectureResponse
                .receive(on: RunLoop.main)
            .print()
                .map { $0 }
            .eraseToAnyPublisher()
        }
    
    
    init() {
        searchLecturePublisher
                    .receive(on: RunLoop.main)
                    .assign(to: \.lectureResult, on: self)
                    .store(in: &disposables)
        search()
    }
    
    func search() {
        lectureHandler.getLectureRank(
            page: page,
            sort: "평점순",
            department: department
        )
    }
    
    func reset() {
        department = "교양학부"
        sort = "평점순"
        types = []
        hashTags = []
    }
    
}
