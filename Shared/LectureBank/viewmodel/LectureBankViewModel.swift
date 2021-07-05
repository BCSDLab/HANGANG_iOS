//
//  LectureBankViewModel.swift
//  hangang (iOS)
//
//  Created by 정태훈 on 2021/02/21.
//

import Foundation
import Combine

class LectureBankViewModel: ObservableObject, Identifiable {
    @Published var query: String = ""
    @Published var department: String = "교양학부" {
        didSet{
            search()
        }
    }
    @Published var page: Int = 1
    
    //id, hits
    @Published var sort: String = "id" {
        didSet{
            search()
        }
    }
    @Published var categories: [String] = [] {
        didSet {
            search()
        }
    }
    
    @Published var lectureBankResult: [LectureBank] = []
    
    var lectureBankHandler: LectureBankHandler = LectureBankHandler()
    
    private var disposables: Set<AnyCancellable> = []
    
    private var searchLectureBankPublisher: AnyPublisher<[LectureBank], Never> {
        lectureBankHandler.$lectureBankResponse
                .receive(on: RunLoop.main)
                .map { $0 }
            .eraseToAnyPublisher()
        }
    
    
    init() {
        
        searchLectureBankPublisher
                    .receive(on: RunLoop.main)
                    .assign(to: \.lectureBankResult, on: self)
                    .store(in: &disposables)
        search()
    }
    
    func search() {
        lectureBankHandler.search(
            department: department,
            keyword: query,
            page: page,
            categories: categories,
            order: sort
        )
    }
    
}
