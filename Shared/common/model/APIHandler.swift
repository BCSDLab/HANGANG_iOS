//
//  APIHandler.swift
//  hangang (iOS)
//
//  Created by 정태훈 on 2021/01/01.
//

import Alamofire
import Combine
import SwiftyJSON

class APIHandler {
        
    var statusCode = Int.zero
    
    func handleResponse<T: Decodable>(_ response: DataResponse<T, AFError>) -> Any? {
        //print(response.data)

        switch response.result {
        case .success:
            print(response.request?.url ?? "")
            return response.value
        case .failure:
            print("======== ERROR Start ========")
            print(response.error)
            print(response.request?.url ?? "")
            print(response.request?.headers)
            let json = JSON(response.data)
            print(json)
            print("======== ERROR End ========")
            return nil
        }
    }
}
