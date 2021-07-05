//
//  LectureBankDetailHandler.swift
//  hangang (iOS)
//
//  Created by 정태훈 on 2021/03/14.
//

import Foundation
import Alamofire

class LectureBankDetailHandler: APIHandler {
    @Published var lectureBankCommentResponse: [Comment] = []
    @Published var lectureBank: LectureBank? = nil
    
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
        
        
        AF.request(url,
                   method: .get)
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
}
