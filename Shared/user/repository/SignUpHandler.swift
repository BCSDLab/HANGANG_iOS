//
//  EmailHandler.swift
//  hangang (iOS)
//
//  Created by 정태훈 on 2021/01/17.
//

import Foundation
import Combine
import Alamofire


struct CheckNicknameRequest: Encodable {
    let nickname: String
}

class SignUpHandler: APIHandler {
    @Published var nicknameCheckResponse: HangangResponse = HangangResponse()
    
    func checkNickname(nickname: String)  {
        
        let url = "http://hangang.in/user/nickname-check"
        
        let data = CheckNicknameRequest(
            nickname: nickname
        )
        
        print(data)
        
        AF.request(url,
                   method: .post,
                   parameters: data,
                   encoder: JSONParameterEncoder.default
        ).responseDecodable { [weak self] (response: DataResponse<HangangResponse, AFError>) in
            guard let weakSelf = self else { return }
                        
            guard let response = weakSelf.handleResponse(response) as? HangangResponse else {
                            return
                        }
                                        
                        weakSelf.nicknameCheckResponse = response
        }
    }

    
}
