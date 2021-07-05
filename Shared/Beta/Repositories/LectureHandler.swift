//
//  LectureHandler.swift
//  hangang (iOS)
//
//  Created by 정태훈 on 2021/03/28.
//

import Foundation
import Combine
import Alamofire
import SwiftyJSON

struct LectureRequest: Encodable {
    /*let classification: [String]?
    let hashtag: [Int]?
    let keyword: String?
    let limit: Int = 10*/
    let department: String?
    let sort: String?
    let page: Int
}

struct IdData: Encodable {
    let id: Int
}

struct ReviewRequest: Encodable {
    let assignment: [IdData]
    let assignment_amount: Int
    let attendance_frequency: Int
    let comment: String
    let difficulty: Int
    let grade_portion: Int
    let hash_tags: [IdData]
    let lecture_id: Int
    let rating: Double
    let semester_id: Int
}

class LectureHandler: APIHandler {
    @Published var lectureResponse: [Lecture] = []
    @Published var reviewResponse: [Review] = []
    @Published var reviewCount: Int = 0
    @Published var totalEvaluationResponse: TotalEvaluation? = nil
    @Published var ratingResponse: [Double] = []
    @Published var semesters: [Int] = []
    @Published var addReviewResponse: HangangResponse? = nil
    
    func search(page: Int)  {
        let url: String = "https://api.hangang.in/lectures"
        
        let data: LectureRequest = LectureRequest(
            department: nil,
            sort: nil,
            page: page
        )
        
        AF.request(url,
                   method: .get,
                   parameters: data,
                   encoder: URLEncodedFormParameterEncoder.default
        ).responseDecodable { [weak self] (response: DataResponse<[Lecture], AFError>) in
            guard let weakSelf = self else { return }
            guard let response = weakSelf.handleResponse(response) as? [Lecture] else {
                            return
                        }
            //print(response)
            weakSelf.lectureResponse = response
        }
    }
    
    func addReview(
        assignment: [Int],
        assignment_amount: Int,
        attendance_frequency: Int,
        comment: String,
        difficulty: Int,
        grade_portion: Int,
        hash_tags: [Int],
        lecture_id: Int,
        rating: Double,
        semester_id: Int
    )  {
        let accessToken = UserDefaults.standard.string(forKey: "access_token")
        
        let url: String = "https://api.hangang.in/reviews"
        
        let data: ReviewRequest = ReviewRequest(
            assignment: assignment.map {
                IdData(id: $0)
            },
            assignment_amount: assignment_amount,
            attendance_frequency: attendance_frequency,
            comment: comment,
            difficulty: difficulty,
            grade_portion: grade_portion,
            hash_tags: hash_tags.map {
                IdData(id: $0)
            },
            lecture_id: lecture_id,
            rating: rating,
            semester_id: semester_id
        )
        
        print(data)
        print(accessToken)
        
        AF.request(url,
                   method: .post,
                   parameters: data,
                   encoder: JSONParameterEncoder.default,
                   headers: [
                    .authorization("Bearer " + (accessToken ?? ""))
                   ]
        ).responseDecodable { [weak self] (response: DataResponse<HangangResponse, AFError>) in
            guard let weakSelf = self else { return }
            guard let response = weakSelf.handleResponse(response) as? HangangResponse else {
                            return
                        }
            print(response.httpStatus)
            print(response.message)
            weakSelf.addReviewResponse = response
        }
    }
    
    func getTotalEvaluation(id: Int)  {
        let url: String = "https://api.hangang.in/evaluation/total/\(id)"
        
        
        AF.request(url,
                   method: .get
        ).responseDecodable { [weak self] (response: DataResponse<TotalEvaluation, AFError>) in
            guard let weakSelf = self else { return }
            guard let response = weakSelf.handleResponse(response) as? TotalEvaluation else {
                            return
                        }
            //print(response)
            weakSelf.totalEvaluationResponse = response
        }
    }
    
    func getRating(id: Int)  {
        let url: String = "https://api.hangang.in/evaluation/rating/\(id)"
        
        
        AF.request(url,
                   method: .get
        ).responseDecodable { [weak self] (response: DataResponse<[Double], AFError>) in
            guard let weakSelf = self else { return }
            guard let response = weakSelf.handleResponse(response) as? [Double] else {
                            return
                        }
            //print(response)
            weakSelf.ratingResponse = response
        }
    }
    
    func getLectureRank(page: Int, sort: String?, department: String?)  {
        let url: String = "https://api.hangang.in/lectures"
        
        /*let data: LectureRequest = LectureRequest(
            department: department,
            sort: sort,
            page: page
        )*/
        
        var parameters = [
            "page": String(page)
        ]
        
        if(department != nil) {
            parameters["department"] = department ?? ""
        }
        
        if(sort != nil) {
            parameters["sort"] = sort ?? "평점순"
        }
        
        print(parameters)
        
        AF.request(url,
                   method: .get,
                   parameters: parameters,
                   encoder: URLEncodedFormParameterEncoder.default
        ).responseDecodable { [weak self] (response: DataResponse<LectureResponse, AFError>) in
            guard let weakSelf = self else { return }
            guard let response = weakSelf.handleResponse(response) as? LectureResponse else {
                            return
                        }
            weakSelf.lectureResponse = response.result ?? []
        }
    }
    
    func getLectureReviews(lectureId: Int)  {
        let url: String = "https://api.hangang.in/reviews/lectures/\(lectureId)"
        
        /*let data: LectureRequest = LectureRequest(
            department: department,
            sort: sort,
            page: page
        )*/
        
        /*var parameters = [
            "page": String(page)
        ]
        
        if(department != nil) {
            parameters["department"] = department ?? ""
        }
        
        if(sort != nil) {
            parameters["sort"] = sort ?? "평점순"
        }*/
        
        //print(parameters)
        
        AF.request(url,
                   method: .get
        ).responseDecodable { [weak self] (response: DataResponse<CommonResponse<Review>, AFError>) in
            guard let weakSelf = self else { return }
            guard let response = weakSelf.handleResponse(response) as? CommonResponse<Review> else {
                            return
                        }
            weakSelf.reviewResponse = (response.result ?? [])
            weakSelf.reviewCount = response.count
        }
    }
    
    func getLectureSemesters(lectureId: Int)  {
        let url: String = "https://api.hangang.in/semesterdates/lectures/\(lectureId)"
        
        AF.request(url,
                   method: .get
        ).responseDecodable { [weak self] (response: DataResponse<[Int], AFError>) in
            guard let weakSelf = self else { return }
            guard let response = weakSelf.handleResponse(response) as? [Int] else {
                            return
                        }
            weakSelf.semesters = response
        }
    }
}
