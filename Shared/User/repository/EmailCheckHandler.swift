//
//  EmailHandler.swift
//  hangang (iOS)
//
//  Created by 정태훈 on 2021/01/17.
//

import Foundation
import Combine
import Alamofire

struct SendEmailRequest: Encodable {
    let portal_account: String
    let flag: Int = 0
}

struct CheckEmailRequest: Encodable {
    let secret: String
    let portal_account: String
    let flag: Int = 0
}

class EmailCheckHandler: APIHandler {
    @Published var emailSendResponse: HangangResponse = HangangResponse()
    @Published var emailCheckResponse: HangangResponse = HangangResponse()
    
    func sendEmail(email: String)  {
        
        let url = "http://hangang.in/user/email"
        
        let data = SendEmailRequest(portal_account: email + "@gmail.com")
        
        AF.request(url,
                   method: .post,
                   parameters: data,
                   encoder: JSONParameterEncoder.default
        ).responseDecodable { [weak self] (response: DataResponse<HangangResponse, AFError>) in
            guard let weakSelf = self else { return }
                        
            guard let response = weakSelf.handleResponse(response) as? HangangResponse else {
                            return
                        }
                                        
                        weakSelf.emailSendResponse = response
        }
    }
    
    func checkEmail(email: String, secret: String) {
        
        let url = "http://hangang.in/user/email/config"
        
        let data = CheckEmailRequest(secret: secret, portal_account: email + "@gmail.com")
        
        AF.request(url,
                   method: .post,
                   parameters: data,
                   encoder: JSONParameterEncoder.default
        ).responseDecodable { [weak self] (response: DataResponse<HangangResponse, AFError>) in
            guard let weakSelf = self else { return }
                        
            guard let response = weakSelf.handleResponse(response) as? HangangResponse else {
                            return
                        }
                                        
                        weakSelf.emailCheckResponse = response
        }
    }
    
}
