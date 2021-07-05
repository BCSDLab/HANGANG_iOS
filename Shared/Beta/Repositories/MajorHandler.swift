//
//  EmailHandler.swift
//  hangang (iOS)
//
//  Created by 정태훈 on 2021/01/17.
//

import Foundation
import Combine
import Alamofire

struct SignUpRequest: Encodable {
    let portal_account: String
    let password: String
    let nickname: String
    let major: [String]
}

class MajorHandler: APIHandler {
    @Published var signUpResponse: HangangResponse = HangangResponse()
    
    func signUp(email: String, password: String, nickname: String, major: [String])  {
        
        let url = "https://api.hangang.in/user/sign-up"
        
        let data = SignUpRequest(
            portal_account: email + "@koreatech.ac.kr",
            password: sha256(str: password),
            nickname: nickname,
            major: major
        )
        
        AF.request(url,
                   method: .post,
                   parameters: data,
                   encoder: JSONParameterEncoder.default
        ).responseDecodable { [weak self] (response: DataResponse<HangangResponse, AFError>) in
            guard let weakSelf = self else { return }
                        
            guard let response = weakSelf.handleResponse(response) as? HangangResponse else {
                            return
                        }
                                        
                        weakSelf.signUpResponse = response
        }
    }
    
}
