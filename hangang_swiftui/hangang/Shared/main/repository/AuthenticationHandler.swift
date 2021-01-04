//
//  AuthenticationHandler.swift
//  hangang (iOS)
//
//  Created by 정태훈 on 2021/01/01.
//

import Foundation
import Combine
import Alamofire

class AuthenticationHandler: APIHandler {
    
    @Published var hangangResponse: TokenLoginResponse?
    @Published var isLoading = false
    
    func loginByToken() {
        isLoading = true
        
        let url = ""
        
        AF.request(url, method: .get).responseDecodable { [weak self] (response: DataResponse<TokenLoginResponse, AFError>) in
            guard let weakSelf = self else { return }
                        
            guard let response = weakSelf.handleResponse(response) as? TokenLoginResponse else {
                            weakSelf.isLoading = false
                            return
                        }
                                        
                        weakSelf.isLoading = false
                        weakSelf.hangangResponse = response
        }
    }
    
}
