//
//  MyViewModel.swift
//  hangang (iOS)
//
//  Created by 정태훈 on 2021/05/16.
//

import Foundation
import Combine

class MyViewModel: ObservableObject, Identifiable {
    
    @Published var token: Token? = nil
    @Published var user: User? = nil
    @Published var lectureCount: LectureCount? = nil
    @Published var purchaseList: [Purchase]? = nil
    
    var myHandler: MyHandler = MyHandler()
    
    private var disposables: Set<AnyCancellable> = []
    
    private var myPublisher: AnyPublisher<User?, Never> {
        return myHandler.$myResponse
                .receive(on: RunLoop.main)
            .print()
                .map { $0 }
            .print()
            .eraseToAnyPublisher()
        }
    
    private var lectureCountPublisher: AnyPublisher<LectureCount?, Never> {
        return myHandler.$myLectureCount
                .receive(on: RunLoop.main)
            .print()
                .map { $0 }
            .print()
            .eraseToAnyPublisher()
        }
    
    init(token: Token) {
        self.token = token
        myPublisher
                    .receive(on: RunLoop.main)
                    .assign(to: \.user, on: self)
                    .store(in: &disposables)
        
        lectureCountPublisher
                    .receive(on: RunLoop.main)
                    .assign(to: \.lectureCount, on: self)
                    .store(in: &disposables)
        
        myHandler.getMy(token: token)
        myHandler.getLectureCount(token: token)
        purchaseList = [
            Purchase(
                id: 9, userID: 8, title: "자료입니다", lecture: Lecture(id: 292, semesterData: nil, top3HashTag: nil, department: nil, code: nil, name: "물리적사고", professor: "김원년", classification: nil, totalRating: nil, lastReviewedAt: nil, reviewCount: nil, isDeleted: nil, createdAt: nil, updatedAt: nil), uploadFiles: [
                    UploadFile(id: 3, fileName: "2017-2.png", ext: "png")
                ])
        ]
    }
    
    
}
