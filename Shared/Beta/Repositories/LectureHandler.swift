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
    let hashtag: [Int]?*/
    let limit: Int = 20
    let department: String
    let sort: String?
    let page: Int
    let keyword: String
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
    @Published var lectureSemesters: [Semester?] = []
    @Published var isLoading: Bool = false
    @Published var likeReviewResponse: [Review] = []
    @Published var getLectureResponse: Lecture? = nil
    @Published var scrapLectureResponse: Lecture? = nil
    @Published var getTimeLectureResponse: [TimeTableLectureInfo] = []

    let semesters: [Semester] = [
        Semester(
                id: 1,
                semester: "2019년 1학기",
                startTime: "20190201",
                isRegular: 1
        ),
        Semester(
                id: 2,
                semester: "2019년 2학기",
                startTime: "20190801",
                isRegular: 1
        ),
        Semester(
                id: 3,
                semester: "2020년 1학기",
                startTime: "20200201",
                isRegular: 1
        ),
        Semester(
                id: 4,
                semester: "2020년 2학기",
                startTime: "20200801",
                isRegular: 1
        ),
        Semester(
                id: 5,
                semester: "2021년 1학기",
                startTime: "20210201",
                isRegular: 1
        ),
        Semester(
                id: 6,
                semester: "2021년 여름학기",
                startTime: "20210501",
                isRegular: 0
        ),
        Semester(
                id: 7,
                semester: "2021년 2학기",
                startTime: "20210801",
                isRegular: 1
        ),
        Semester(
                id: 8,
                semester: "2021년 겨울학기",
                startTime: "20211101",
                isRegular: 0
        ),
        Semester(
                id: 9,
                semester: "2022년 1학기",
                startTime: "20220201",
                isRegular: 1
        )
    ]

    @Published var addReviewResponse: HangangResponse? = nil
    
    func search(page: Int, department: String, keyword: String?)  {
        isLoading = true
        let url: String = "https://api.hangang.in/lectures"
        
        let data: LectureRequest = LectureRequest(
            department: department,
            sort: nil,
            page: page,
            keyword: keyword ?? ""
        )
        
        AF.request(url,
                   method: .get,
                   parameters: data,
                   encoder: URLEncodedFormParameterEncoder.default
        ).responseDecodable { [weak self] (response: DataResponse<CommonResponse<Lecture>, AFError>) in
            guard let weakSelf = self else { return }
            guard let response = weakSelf.handleResponse(response) as? CommonResponse<Lecture> else {
                            return
                        }
            //print(response)
            weakSelf.isLoading = false
            weakSelf.lectureResponse = response.result ?? []
        }
    }

    func getTimeLecture(lectureId: Int)  {
        isLoading = true
        let url: String = "https://api.hangang.in/class/lectures/\(lectureId)"
        let accessToken = UserDefaults.standard.string(forKey: "access_token")

        AF.request(url,
                method: .get,
                headers: [
                    .authorization("Bearer " + (accessToken ?? ""))
                ]
        ).responseDecodable { [weak self] (response: DataResponse<[TimeTableLectureInfo], AFError>) in
            guard let weakSelf = self else { return }
            guard let response = weakSelf.handleResponse(response) as? [TimeTableLectureInfo] else {
                return
            }
            //print(response)
            weakSelf.isLoading = false
            weakSelf.getTimeLectureResponse = response
        }
    }

    func getLecture(lectureId: Int)  {
        isLoading = true
        let url: String = "https://api.hangang.in/lectures/\(lectureId)"
        let accessToken = UserDefaults.standard.string(forKey: "access_token")

        AF.request(url,
                method: .get,
                headers: [
                    .authorization("Bearer " + (accessToken ?? ""))
                ]
        ).responseDecodable { [weak self] (response: DataResponse<Lecture, AFError>) in
            guard let weakSelf = self else { return }
            guard let response = weakSelf.handleResponse(response) as? Lecture else {
                return
            }
            //print(response)
            weakSelf.isLoading = false
            weakSelf.getLectureResponse = response
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
        ).responseDecodable { [weak self] (response: DataResponse<TotalEvaluation?, AFError>) in
            guard let weakSelf = self else { return  }
            guard let response = weakSelf.handleResponse(response) as? TotalEvaluation? else {
                            return
                        }
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
    
    func getLectureRank(page: Int, sort: String?, department: String?, query: String?)  {
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

        if(query != nil && query != "") {
            parameters["keyword"] = query ?? ""
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
        self.isLoading = true
        let url: String = "https://api.hangang.in/reviews/lectures/\(lectureId)"
        let accessToken = UserDefaults.standard.string(forKey: "access_token")
        
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
                   method: .get,
                headers: [
                    .authorization("Bearer " + (accessToken ?? ""))
                ]
        ).responseDecodable { [weak self] (response: DataResponse<CommonResponse<Review>, AFError>) in
            guard let weakSelf = self else { return }
            guard let response = weakSelf.handleResponse(response) as? CommonResponse<Review> else {
                            return
                        }
            weakSelf.isLoading = false
            weakSelf.reviewResponse = (response.result ?? [])
            weakSelf.reviewCount = response.count
        }
    }

    func recommendReview(review: Review, reviews: [Review])  {
        self.isLoading = true
        let url: String = "https://api.hangang.in/review/recommend"
        let accessToken = UserDefaults.standard.string(forKey: "access_token")
        print(review)

        AF.request(url,
                method: .post,
                parameters: [
                    "id": review.id
                ],
                encoder: JSONParameterEncoder.default,
                headers: [
                    .authorization("Bearer " + (accessToken ?? ""))
                ]
        ).responseJSON() { response in

            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print(json)

                if(json["httpStatus"] == "OK" && !review.isLiked) {
                    var changedReview = review
                    var changedReviews = reviews
                    let changedIndex = reviews.index(of: changedReview)
                    changedReview.isLiked = true
                    changedReview.likes = review.likes + 1
                    changedReviews[changedIndex!] = changedReview
                    print(changedReviews)
                    self.likeReviewResponse = changedReviews
                } else {
                    self.likeReviewResponse = reviews
                }


                break
            case .failure(let value):
                let json = JSON(value)
                print(json)
                break
            }


        }
    }

    func scrapLecture(lecture: Lecture)  {
        self.isLoading = true
        let url: String = "https://api.hangang.in/scrap/lecture"
        let accessToken = UserDefaults.standard.string(forKey: "access_token")

        AF.request(url,
                method: .post,
                parameters: [
                    "id": lecture.id
                ],
                encoder: JSONParameterEncoder.default,
                headers: [
                    .authorization("Bearer " + (accessToken ?? ""))
                ]
        ).responseJSON() { response in

            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print(json)

                if(json["httpStatus"] == "OK" && !(lecture.isScraped ?? false)) {
                    var changedLecture = lecture
                    changedLecture.isScraped = true

                    self.scrapLectureResponse = changedLecture
                }


                break
            case .failure(let value):
                let json = JSON(value)
                print(json)
                break
            }


        }/*.responseDecodable { [weak self] (response: DataResponse<Lecture, AFError>) in
            guard let weakSelf = self else { return }
            guard let response = weakSelf.handleResponse(response) as? Lecture else {
                return
            }
            weakSelf.isLoading = false
            weakSelf.scrapLectureResponse = response
        }*/
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
            weakSelf.lectureSemesters = response.map { l in
                return weakSelf.semesters.first { s in
                    return l == s.id
                }
            }
        }
    }
}
