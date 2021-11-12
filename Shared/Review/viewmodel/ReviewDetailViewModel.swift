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
    @Published var reviewResult: [Review] = [] {
        didSet {
            objectWillChange.send()
        }
    }
    @Published var reviewCount: Int = 0
    @Published var lecture: Lecture? = nil
    @Published var subLecture: Lecture? = nil {
        didSet {
            objectWillChange.send()
        }
    }
    @Published var timeTableLecture: [TimeTableLectureInfo] = [] {
        didSet {
            print("classTimeString")
            print("\(timeTableLecture.map { $0.classTimeString})")
        }
    }
    
    var lectureHandler: LectureHandler = LectureHandler()

    let objectWillChange = ObservableObjectPublisher()
    
    private var disposables: Set<AnyCancellable> = []
    
    private var totalEvaluationPublisher: AnyPublisher<TotalEvaluation?, Never> {
        lectureHandler.$totalEvaluationResponse
                .receive(on: RunLoop.main)
                .map { $0 }
            .eraseToAnyPublisher()
        }
    
    private var ratingPublisher: AnyPublisher<[Double], Never> {
        lectureHandler.$ratingResponse
                .receive(on: RunLoop.main)
                .map { $0 }
            .eraseToAnyPublisher()
        }
    
    private var reviewPublisher: AnyPublisher<[Review], Never> {
        lectureHandler.$reviewResponse
                .receive(on: RunLoop.main)
                .map { $0 }
            .eraseToAnyPublisher()
        }
    
    private var reviewCountPublisher: AnyPublisher<Int, Never> {
        lectureHandler.$reviewCount
                .receive(on: RunLoop.main)
                .map { $0 }
            .eraseToAnyPublisher()
        }

    private var likeReviewPublisher: AnyPublisher<[Review], Never> {
        lectureHandler.$likeReviewResponse
                .receive(on: RunLoop.main)
                .map { $0 }
                .eraseToAnyPublisher()
    }

    private var scrapLecturePublisher: AnyPublisher<Lecture?, Never> {
        lectureHandler.$scrapLectureResponse
                .receive(on: RunLoop.main)
                .map { $0 }
                .eraseToAnyPublisher()
    }

    private var timeTableLecturePublisher: AnyPublisher<[TimeTableLectureInfo], Never> {
        lectureHandler.$getTimeLectureResponse
                .receive(on: RunLoop.main)
                .map { $0 }
                .eraseToAnyPublisher()
    }

    private var getLecturePublisher: AnyPublisher<Lecture?, Never> {
        lectureHandler.$getLectureResponse
                .receive(on: RunLoop.main)
                .map { $0 }
                .eraseToAnyPublisher()
    }
    
    init(lecture: Lecture) {
        self.lecture = lecture
        getLecturePublisher
                .receive(on: RunLoop.main)
                .assign(to: \.subLecture, on: self)
                .store(in: &disposables)
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

        likeReviewPublisher
                .receive(on: RunLoop.main)
                .assign(to: \.reviewResult, on: self)
                .store(in: &disposables)

        scrapLecturePublisher
                .receive(on: RunLoop.main)
                .assign(to: \.subLecture, on: self)
                .store(in: &disposables)

        timeTableLecturePublisher
                .receive(on: RunLoop.main)
                .assign(to: \.timeTableLecture, on: self)
                .store(in: &disposables)

        lectureHandler.getLecture(
                lectureId: lecture.id ?? -1
        )
        lectureHandler.getTimeLecture(
                lectureId: lecture.id ?? -1
        )
    }
    
    func getTotalEvaluation() {
        lectureHandler.getTotalEvaluation(
            id: lecture?.id ?? -1
        )
    }
    
    func getRating() {
        lectureHandler.getRating(
            id: lecture?.id ?? -1
        )
    }

    func recommendReview(review: Review) {
        lectureHandler.recommendReview(
                review: review,
        reviews: reviewResult
        )
    }

    func scrapLecture() {
        if(subLecture != nil) {
            lectureHandler.scrapLecture(lecture: subLecture!)
        }
    }
    
    func getReviews() {
        lectureHandler.getLectureReviews(
            lectureId: lecture?.id ?? -1
        )
    }
    
}
