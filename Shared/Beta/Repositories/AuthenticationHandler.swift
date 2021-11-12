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
    @Published var tokenTestResponse: String = ""
    @Published var isLoading = false
    @Published var refreshTokenResponse: Token? = nil
    @Published var myResponse: User? = nil

    func testToken(token: Token?) {
        isLoading = true

        let url = "https://api.hangang.in/user/auth-test"


        AF.request(url,
                method: .get,
                headers: [
                    .authorization("Bearer " + (token?.access_token ?? ""))
                ]
        ).responseDecodable { [weak self] (response: DataResponse<HangangResponse, AFError>) in
            guard let weakSelf = self else { return }

            guard let response = weakSelf.handleResponse(response) as? HangangResponse else {
                weakSelf.isLoading = false
                return
            }

            weakSelf.isLoading = false
            weakSelf.tokenTestResponse = response.httpStatus ?? ""
        }
    }
    
    func refreshToken(token: Token?) {
        isLoading = true

        if(!(token?.refresh_token ?? "").isEmpty) {
            let url = "https://api.hangang.in/user/refresh"


            AF.request(url,
                    method: .post,
                    headers: [
                        HTTPHeader(name: "RefreshToken", value: "Bearer " + (token?.refresh_token ?? ""))
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
        } else {
            self.isLoading = false
            self.refreshTokenResponse = nil
        }
    }

    func getMy(token: Token?)  {
        self.isLoading = true
        let url = "https://api.hangang.in/user/me"

        AF.request(url,
                method: .get,
                headers: [
                    .authorization("Bearer " + (token?.access_token ?? ""))
                ]
        ).responseDecodable { [weak self] (response: DataResponse<User, AFError>) in
            guard let weakSelf = self else { return }

            guard let response = weakSelf.handleResponse(response) as? User else {
                weakSelf.isLoading = false
                return
            }
            weakSelf.isLoading = false
            weakSelf.myResponse = response
        }
    }
}
