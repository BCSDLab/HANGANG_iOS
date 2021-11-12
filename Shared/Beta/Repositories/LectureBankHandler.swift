//
//  LectureBankHandler.swift
//  hangang (iOS)
//
//  Created by 정태훈 on 2021/02/21.
//

import Foundation
import Combine
import Alamofire
import SwiftyJSON

struct LectureBankRequest: Encodable {
    //let cursor: Int
    let department: String?
    let keyword: String?
    let limit: Int = 10
    let order: String
    let page: Int
    let category: [String]?
}

struct UploadLectureBankRequest: Encodable {
    //let cursor: Int
    let category: [String]
    let content: String
    let files: [String]
    let lecture_id: Int
    let semester_id: Int
    let title: String
}

class LectureBankHandler: APIHandler {
    @Published var lectureBankResponse: [LectureBank] = []
    @Published var hitLectureBankResponse: [LectureBank] = []
    @Published var uploadedLectureBankResponse: HangangResponse? = nil
    @Published var lectureBankCommentResponse: [Comment] = []
    @Published var isLoading: Bool = false
    
    func search(department:String, keyword: String?, page: Int, categories: [String], order: String)  {
        isLoading = true
        let url = "https://api.hangang.in/lecture-banks"
        
        let data = LectureBankRequest(
            department: department,
                keyword: keyword ?? "",
            order: order,
            page: page,
            category: categories
        )
        
        
        AF.request(url,
                   method: .get,
                   parameters: data,
                   encoder: URLEncodedFormParameterEncoder.default
        ).responseDecodable { [weak self] (response: DataResponse<CommonResponse<LectureBank>, AFError>) in
            guard let weakSelf = self else { return }
            guard let response = weakSelf.handleResponse(response) as? CommonResponse<LectureBank> else {
                            return
                        }
            //weakSelf.lectureBankResponse = response
            weakSelf.isLoading = false
            weakSelf.lectureBankResponse = (response.result ?? [])
            //weakSelf.reviewCount = response.count
        }
    }

    func getHitLectureBank()  {
        isLoading = true
        let url = "https://api.hangang.in/lecture-banks/hit"

        AF.request(url,
                method: .get
        ).responseDecodable { [weak self] (response: DataResponse<[LectureBank], AFError>) in
            guard let weakSelf = self else { return }
            guard let response = weakSelf.handleResponse(response) as? [LectureBank] else {
                return
            }
            //weakSelf.lectureBankResponse = response
            weakSelf.isLoading = false
            weakSelf.hitLectureBankResponse = response
            //weakSelf.reviewCount = response.count
        }
    }

    func uploadLectureBank(lectureBank: UploadLectureBankRequest)  {
        isLoading = true
        let url = "https://api.hangang.in/lecture-banks"

        let accessToken = UserDefaults.standard.string(forKey: "access_token")

        AF.request(url,
                method: .post,
                parameters: lectureBank,
                encoder: URLEncodedFormParameterEncoder.default,
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
            weakSelf.uploadedLectureBankResponse = response
        }
    }
    
}