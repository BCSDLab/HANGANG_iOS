//
//  LectureBankDetailViewModel.swift
//  hangang (iOS)
//
//  Created by 정태훈 on 2021/03/14.
//

import Foundation
import Combine

class LectureBankDetailViewModel: ObservableObject, Identifiable {
    @Published var comment: String = ""
    @Published var lectureBankResult: LectureBank? = nil
    @Published var lectureBankCommentsResult: [Comment] = []
    
    var lectureBankDetailHandler: LectureBankDetailHandler = LectureBankDetailHandler()
    
    private var disposables: Set<AnyCancellable> = []
    
    private var LectureBankPublisher: AnyPublisher<LectureBank?, Never> {
        lectureBankDetailHandler.$lectureBank
                .receive(on: RunLoop.main)
                .map { $0 }
            .eraseToAnyPublisher()
        }
    
    private var LectureBankCommentPublisher: AnyPublisher<[Comment], Never> {
        lectureBankDetailHandler.$lectureBankCommentResponse
                .receive(on: RunLoop.main)
                .map { $0 }
            .eraseToAnyPublisher()
        }
    
    
    init(lectureBankId: Int) {
        
        LectureBankPublisher
                    .receive(on: RunLoop.main)
                    .assign(to: \.lectureBankResult, on: self)
                    .store(in: &disposables)
        
        LectureBankCommentPublisher
                    .receive(on: RunLoop.main)
                    .assign(to: \.lectureBankCommentsResult, on: self)
                    .store(in: &disposables)
        
        getLectureBank(lectureBankId: lectureBankId)
        getLectureBankComments(lectureBankId: lectureBankId)
    }
    
    func getLectureBank(lectureBankId: Int) {
        lectureBankDetailHandler.getLectureBank(
            lectureBankId: lectureBankId
        )
    }
    
    func getLectureBankComments(lectureBankId: Int) {
        lectureBankDetailHandler.getLectureBankComment(
            lectureBankId: lectureBankId
        )
    }
    
}
