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
            search(query: query)
        }
    }
    @Published var page: Int = 1
    
    //id, hits
    @Published var sort: String = "id" {
        didSet{
            search(query: query)
        }
    }
    @Published var categories: [String] = [] {
        didSet {
            search(query: query)
        }
    }
    
    @Published var lectureBankResult: [LectureBank] = []
    @Published var isLoading: Bool = false
    @Published var isMax: Bool = false

    @Published var updateBankResult: [LectureBank] = [] {
        didSet {
            if(updateBankResult.isEmpty) {
                isMax = true
            } else {
                self.lectureBankResult = lectureBankResult + updateBankResult
            }
        }
    }
    
    var lectureBankHandler: LectureBankHandler = LectureBankHandler()
    
    private var disposables: Set<AnyCancellable> = []
    
    private var searchLectureBankPublisher: AnyPublisher<[LectureBank], Never> {
        lectureBankHandler.$lectureBankResponse
                .receive(on: RunLoop.main)
                .map { $0 }
            .eraseToAnyPublisher()
        }

    private var loadingPublisher: AnyPublisher<Bool, Never> {
        lectureBankHandler.$isLoading
                .receive(on: RunLoop.main)
                .map { $0 }
                .eraseToAnyPublisher()
    }
    
    init() {
        
        searchLectureBankPublisher
                    .receive(on: RunLoop.main)
                    .assign(to: \.updateBankResult, on: self)
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
        lectureBankHandler.search(
            department: department,
            keyword: query,
            page: page,
            categories: categories,
            order: sort
        )
    }

    func fetch() {
        if(!isMax) {
            page = page + 1
            lectureBankHandler.search(
                    department: department,
                    keyword: self.query,
                    page: page,
                    categories: categories,
                    order: sort
            )
        }
    }
    
}
