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
    @Published var refreshTokenResponse: Token?

    func testToken(token: Token) {
        isLoading = true

        let url = "https://api.hangang.in/user/auth-test"


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
    
    func refreshToken(token: Token) {
        isLoading = true

        let url = "https://api.hangang.in/user/refresh"


        AF.request(url,
                method: .post,
                headers: [
                    HTTPHeader(name: "RefreshToken", value: "Bearer " + token.refresh_token)
                ]
        ).responseDecodable { [weak self] (response: DataResponse<Token, AFError>) in
            guard let weakSelf = self else { return }

            guard let response = weakSelf.handleResponse(response) as? Token else {
                weakSelf.isLoading = false
                return
            }

            weakSelf.isLoading = false
            weakSelf.refreshTokenResponse = response
        }
    }
    
}