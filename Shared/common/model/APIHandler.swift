//
//  APIHandler.swift
//  hangang (iOS)
//
//  Created by 정태훈 on 2021/01/01.
//

import Alamofire
import Combine

class APIHandler {
        
    var statusCode = Int.zero
    
    func handleResponse<T: Decodable>(_ response: DataResponse<T, AFError>) -> Any? {
        switch response.result {
        case .success:
            return response.value
        case .failure:
            return nil
        }
    }
}
