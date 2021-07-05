//
//  ReviewDetailViewModel.swift
//  hangang (iOS)
//
//  Created by 정태훈 on 2021/06/13.
//

import Foundation
import Combine

class ReviewDetailViewModel: ObservableObject, Identifiable {
    @Published var totalEvaluation: TotalEvaluation? = nil
    @Published var rating: [Double] = []
    @Published var reviewResult: [Review] = []
    @Published var reviewCount: Int = 0
    var lecture: Lecture
    
    var lectureHandler: LectureHandler = LectureHandler()
    
    private var disposables: Set<AnyCancellable> = []
    
    private var totalEvaluationPublisher: AnyPublisher<TotalEvaluation?, Never> {
        lectureHandler.$totalEvaluationResponse
                .receive(on: RunLoop.main)
            .print()
                .map { $0 }
            .eraseToAnyPublisher()
        }
    
    private var ratingPublisher: AnyPublisher<[Double], Never> {
        lectureHandler.$ratingResponse
                .receive(on: RunLoop.main)
            .print()
                .map { $0 }
            .eraseToAnyPublisher()
        }
    
    private var reviewPublisher: AnyPublisher<[Review], Never> {
        lectureHandler.$reviewResponse
                .receive(on: RunLoop.main)
            .print()
                .map { $0 }
            .eraseToAnyPublisher()
        }
    
    private var reviewCountPublisher: AnyPublisher<Int, Never> {
        lectureHandler.$reviewCount
                .receive(on: RunLoop.main)
            .print()
                .map { $0 }
            .eraseToAnyPublisher()
        }
    
    init(lecture: Lecture) {
        self.lecture = lecture
        totalEvaluationPublisher
                    .receive(on: RunLoop.main)
                    .assign(to: \.totalEvaluation, on: self)
                    .store(in: &disposables)
        ratingPublisher
                    .receive(on: RunLoop.main)
                    .assign(to: \.rating, on: self)
                    .store(in: &disposables)
        
        reviewPublisher
                    .receive(on: RunLoop.main)
                    .assign(to: \.reviewResult, on: self)
                    .store(in: &disposables)
        
        reviewCountPublisher
                    .receive(on: RunLoop.main)
                    .assign(to: \.reviewCount, on: self)
                    .store(in: &disposables)
    }
    
    func getTotalEvaluation() {
        lectureHandler.getTotalEvaluation(
            id: lecture.id!
        )
    }
    
    func getRating() {
        lectureHandler.getRating(
            id: lecture.id!
        )
    }
    
    func getReviews() {
        lectureHandler.getLectureReviews(
            lectureId: lecture.id!
        )
    }
    
}
