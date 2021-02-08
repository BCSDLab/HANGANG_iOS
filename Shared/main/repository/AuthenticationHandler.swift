//
//  AuthenticationHandler.swift
//  hangang (iOS)
//
//  Created by 정태훈 on 2021/01/01.
//

import Foundation
import Combine
import Alamofire

struct TokenLoginRequest: Encodable {
    let token: String
}

class AuthenticationHandler: APIHandler {
    @Published var tokenTestResponse: HangangResponse?
    @Published var isLoading = false


    func testToken(token: Token) {
        isLoading = true

        let url = "https://hangang.in/user/auth-test"


        AF.request(url,
                method: .get,
                headers: [
                    .authorization("Bearer " + token.access_token)
                ]
        ).responseDecodable { [weak self] (response: DataResponse<HangangResponse, AFError>) in
            guard let weakSelf = self else { return }

            guard let response = weakSelf.handleResponse(response) as? HangangResponse else {
                weakSelf.isLoading = false
                return
            }

            weakSelf.isLoading = false
            weakSelf.tokenTestResponse = response
        }
    }
    
}
