//
//  FindPasswordHandler.swift
//  hangang (iOS)
//
//  Created by 정태훈 on 2021/02/21.
//

import Foundation
import Combine
import Alamofire

struct SendPasswordEmailRequest: Encodable {
    let portal_account: String
    let flag: Int = 1
}

struct CheckPasswordEmailRequest: Encodable {
    let secret: String
    let portal_account: String
    let flag: Int = 1
}

class FindPasswordHandler: APIHandler {
    @Published var emailPasswordSendResponse: HangangResponse = HangangResponse()
    @Published var emailPasswordCheckResponse: HangangResponse = HangangResponse()

    func sendEmail(email: String)  {

        let url = "https://api.hangang.in/user/email"

        let data = SendPasswordEmailRequest(portal_account: email + "@koreatech.ac.kr")

        AF.request(url,
                method: .post,
                parameters: data,
                encoder: JSONParameterEncoder.default
        ).responseDecodable { [weak self] (response: DataResponse<HangangResponse, AFError>) in
            guard let weakSelf = self else { return }

            guard let response = weakSelf.handleResponse(response) as? HangangResponse else {
                return
            }

            weakSelf.emailPasswordSendResponse = response
        }
    }

    func checkEmail(email: String, secret: String) {

        let url = "https://api.hangang.in/user/email/config"

        let data = CheckPasswordEmailRequest(secret: secret, portal_account: email + "@koreatech.ac.kr")

        AF.request(url,
                method: .post,
                parameters: data,
                encoder: JSONParameterEncoder.default
        ).responseDecodable { [weak self] (response: DataResponse<HangangResponse, AFError>) in
            guard let weakSelf = self else { return }

            guard let response = weakSelf.handleResponse(response) as? HangangResponse else {
                return
            }

            weakSelf.emailPasswordCheckResponse = response
        }
    }

}
