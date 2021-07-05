//
//  ChangePasswordHandler.swift
//  hangang (iOS)
//
//  Created by 정태훈 on 2021/02/22.
//

import Foundation
import Combine
import Alamofire

struct ChangePasswordRequest: Encodable {
    let portal_account: String
    let password: String
}

class ChangePasswordHandler: APIHandler {
    @Published var changePasswordResponse: HangangResponse = HangangResponse()
    
    func changePassword(email: String, password: String)  {
        
        let url = "https://api.hangang.in/user/password-find"
        
        let data = ChangePasswordRequest(
            portal_account: email + "@koreatech.ac.kr",
            password: sha256(str: password)
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
                                        
                        weakSelf.changePasswordResponse = response
        }
    }
    
}
