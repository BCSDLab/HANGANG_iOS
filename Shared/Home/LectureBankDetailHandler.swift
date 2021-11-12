//
//  LectureBankDetailHandler.swift
//  hangang (iOS)
//
//  Created by 정태훈 on 2021/03/14.
//

import Foundation
import Alamofire
import SwiftyJSON

struct AddCommentRequest: Codable {
    let comments: String
}

class LectureBankDetailHandler: APIHandler {
    @Published var lectureBankCommentResponse: [Comment] = []
    @Published var lectureBank: LectureBank? = nil
    @Published var addCommentId: Int? = nil
    @Published var purchaseResult: String? = nil
    @Published var downloadLink: String? = nil
    @Published var scrapLectureBank: LectureBank? = nil
    @Published var hitLectureBank: LectureBank? = nil


    func getLectureBankComment(lectureBankId: Int)  {
        let url = "https://api.hangang.in/lecture-banks/\(lectureBankId)/comments"


        AF.request(url,
                        method: .get)
                .responseDecodable { [weak self] (response: DataResponse<CommentResponse<Comment>, AFError>) in
                    guard let weakSelf = self else { return }
                    guard let response = weakSelf.handleResponse(response) as? CommentResponse<Comment> else {
                        return
                    }
                    //weakSelf.lectureBankResponse = response
                    weakSelf.lectureBankCommentResponse = (response.comments ?? [])
                    //weakSelf.reviewCount = response.count
                }
    }


    func getLectureBank(lectureBankId: Int)  {
        let url = "https://api.hangang.in/lecture-banks/\(lectureBankId)"
        let accessToken = UserDefaults.standard.string(forKey: "access_token")


        AF.request(url,
                        method: .get,
                        headers: [
                            .authorization("Bearer " + (accessToken ?? ""))
                        ])
                .responseDecodable { [weak self] (response: DataResponse<LectureBank, AFError>) in
                    guard let weakSelf = self else { return }
                    guard let response = weakSelf.handleResponse(response) as? LectureBank else {
                        return
                    }
                    //weakSelf.lectureBankResponse = response
                    weakSelf.lectureBank = response
                    //weakSelf.reviewCount = response.count
                }
    }

    func hitLectureBank(lectureBank: LectureBank)  {
        let url: String = "https://api.hangang.in/lecture-banks/hit/\(lectureBank.id)"
        let accessToken = UserDefaults.standard.string(forKey: "access_token")

        AF.request(url,
                method: .post,
                parameters: [
                    "id": lectureBank.id
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

                if(json["httpStatus"] == "OK") {
                    var changedLectureBank = lectureBank

                    if(!lectureBank.isHit) {
                        changedLectureBank.isHit = true
                        changedLectureBank.hits = lectureBank.hits + 1;
                        self.hitLectureBank = changedLectureBank
                    } else {
                        self.hitLectureBank = lectureBank
                    }
                }


                break
            case .failure(let value):
                let json = JSON(value)
                print(json)
                break
            }


        }
    }

    func scrapLectureBank(lectureBank: LectureBank)  {
        let url: String = "https://api.hangang.in/lecture-banks/scrap/\(lectureBank.id)"
        let accessToken = UserDefaults.standard.string(forKey: "access_token")

        AF.request(url,
                method: .post,
                parameters: [
                    "id": lectureBank.id
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

                if(json["httpStatus"] == "OK") {
                    self.scrapLectureBank = lectureBank
                }


                break
            case .failure(let value):
                let json = JSON(value)
                print(json)
                break
            }


        }
    }

    func addComment(lectureBankId: Int, comment: String)  {
        let url = "https://api.hangang.in/lecture-banks/\(lectureBankId)/comment"

        let accessToken = UserDefaults.standard.string(forKey: "access_token")

        let data = AddCommentRequest(comments: comment)

        AF.request(url,
                        method: .post,
                        parameters: data,
                        encoder: JSONParameterEncoder.default,
                        headers: [
                            .authorization("Bearer " + (accessToken ?? ""))
                        ]
                        )
                .responseDecodable { [weak self] (response: DataResponse<Int, AFError>) in
                    guard let weakSelf = self else { return }
                    guard let response = weakSelf.handleResponse(response) as? Int else {
                        return
                    }
                    //weakSelf.lectureBankResponse = response
                    weakSelf.addCommentId = response
                    //weakSelf.reviewCount = response.count
                }
    }

    func purchaseLectureBank(lectureBankId: Int)  {
        let url = "https://api.hangang.in/lecture-banks/purchase/\(lectureBankId)"

        let accessToken = UserDefaults.standard.string(forKey: "access_token")

        AF.request(url,
                        method: .post,
                        headers: [
                            .authorization("Bearer " + (accessToken ?? ""))
                        ]
                )
                .responseDecodable { [weak self] (response: DataResponse<HangangResponse, AFError>) in
                    guard let weakSelf = self else { return }
                    guard let response = weakSelf.handleResponse(response) as? HangangResponse else {
                        return
                    }
                    //weakSelf.lectureBankResponse = response
                    weakSelf.purchaseResult = response.httpStatus
                    //weakSelf.reviewCount = response.count
                }
    }
    
    func getDownloadLink(uploadedFileId: Int)  {
        let url = "https://api.hangang.in/lecture-banks/file/download/\(uploadedFileId)"
        let accessToken = UserDefaults.standard.string(forKey: "access_token")
        print(accessToken)

        AF.request(url,
                        method: .get,
                        headers: [
                            .authorization("Bearer " + (accessToken ?? ""))
                        ])
                .responseString{ response in
                    do {
                        self.downloadLink = try response.result.get()
                    } catch(let e) {
                        print(e)
                    }
                }
    }
    /*
     {
    "message": "강의자료가 구매되었습니다.",
    "httpStatus": "OK"
}
     */
}
