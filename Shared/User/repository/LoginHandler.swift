//
//  LoginHandler.swift
//  hangang (iOS)
//
//  Created by 정태훈 on 2021/01/10.
//

import Foundation
import Combine
import Alamofire

struct LoginRequest: Encodable {
    let portal_account: String
    let password: String
}

class LoginHandler: APIHandler {
    
    @Published var loginResponse: Token?
    @Published var isLoading = false
    
    func login(email: String, password: String)  {
        self.isLoading = true
        let url = "http://hangang.in/user/login"

        print(sha256(str: password));
        
        let data = LoginRequest(
            portal_account: email + "@gmail.com",
            password: sha256(str: password)
        )
        
        print(data)
        
        AF.request(url,
                   method: .post,
                   parameters: data,
                   encoder: JSONParameterEncoder.default
        ).responseDecodable { [weak self] (response: DataResponse<Token, AFError>) in
            guard let weakSelf = self else { return }
                        
            guard let response = weakSelf.handleResponse(response) as? Token else {
                weakSelf.isLoading = false
                            return
                        }
            weakSelf.isLoading = false
            weakSelf.loginResponse = response
        }
    }
    
}
