//
//  WriteReviewViewModel.swift
//  hangang (iOS)
//
//  Created by 정태훈 on 2021/06/19.
//

import Foundation
import Combine

class WriteReviewViewModel: ObservableObject, Identifiable {
    @Published var semester: Int? = nil
    @Published var semesters: [Int] = []
    
    @Published var attendanceFrequency: Int = 3
    @Published var assignments: [Int] = []
    @Published var assignmentAmount: Int = 3
    @Published var difficulty: Int = 3
    @Published var gradePortion: Int = 3
    @Published var hashTags: [Int] = []
    
    @Published var rating: Double = 5.0
    @Published var comment: String = ""
    
    @Published var response: HangangResponse? = nil {
        didSet{
            if(response != nil) {
                responseChange.send(response!)
            }
        }
    }
    
    let responseChange = PassthroughSubject<HangangResponse, Never>()
    /*
     Optional("OK")
     Optional("정상적으로 작성되었습니다.")
     */
    
    let lecture: Lecture
    
    var lectureHandler: LectureHandler = LectureHandler()
    
    private var disposables: Set<AnyCancellable> = []
    
    private var semestersPublisher: AnyPublisher<[Int], Never> {
        lectureHandler.$semesters
                .receive(on: RunLoop.main)
            .print()
                .map { $0 }
            .eraseToAnyPublisher()
        }
    
    private var addReviewPublisher: AnyPublisher<HangangResponse?, Never> {
        lectureHandler.$addReviewResponse
                .receive(on: RunLoop.main)
            .print()
                .map { $0 }
            .eraseToAnyPublisher()
        }
    /*private var totalEvaluationPublisher: AnyPublisher<TotalEvaluation?, Never> {
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
        }*/
    
    init(lecture: Lecture) {
        self.lecture = lecture
        semestersPublisher
                    .receive(on: RunLoop.main)
                    .assign(to: \.semesters, on: self)
                    .store(in: &disposables)
        addReviewPublisher
                    .receive(on: RunLoop.main)
                    .assign(to: \.response, on: self)
                    .store(in: &disposables)
        /*ratingPublisher
                    .receive(on: RunLoop.main)
                    .assign(to: \.rating, on: self)
                    .store(in: &disposables)
        
        reviewPublisher
                    .receive(on: RunLoop.main)
                    .assign(to: \.reviewResult, on: self)
                    .store(in: &disposables)
        
        */
        getSemesters(lecture: lecture)
    }
    
    func getSemesters(lecture: Lecture) {
        lectureHandler.getLectureSemesters(
            lectureId: lecture.id!
        )
    }
    
    func addReview() {
        lectureHandler.addReview(
            assignment: assignments,
            assignment_amount: assignmentAmount,
            attendance_frequency: attendanceFrequency,
            comment: comment,
            difficulty: difficulty,
            grade_portion: gradePortion,
            hash_tags: hashTags,
            lecture_id: lecture.id!,
            rating: rating,
            semester_id: semester!
        )
    }
    
    /*func getTotalEvaluation() {
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
    }*/
    
}
