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
    //let keyword: String
    let limit: Int = 10
    let order: String
    let page: Int
    let category: [String]?
}

class LectureBankHandler: APIHandler {
    @Published var lectureBankResponse: [LectureBank] = []
    @Published var lectureBankCommentResponse: [Comment] = []
    
    func search(department:String, keyword: String, page: Int, categories: [String], order: String)  {
        let url = "https://api.hangang.in/lecture-banks"
        
        let data = LectureBankRequest(
            department: department,
            order: order,
            page: 1,
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
            weakSelf.lectureBankResponse = (response.result ?? [])
            //weakSelf.reviewCount = response.count
        }
    }
    
    
    
}
