//
//  MyHandler.swift
//  hangang (iOS)
//
//  Created by 정태훈 on 2021/05/16.
//

import Foundation
import Combine
import Alamofire

class MyHandler: APIHandler {
    
    @Published var myResponse: User?
    @Published var myLectureCount: LectureCount?
    @Published var pointList: [Point]?
    @Published var isLoading = false
    
    func getMy(token: Token)  {
        self.isLoading = true
        let url = "https://api.hangang.in/user/me"
        
        AF.request(url,
                   method: .get,
                   parameters: ["":""],
                   encoder: URLEncodedFormParameterEncoder.default,
                   headers: [
                    .authorization("Bearer " + token.access_token),
                    HTTPHeader(
                    name: "RefreshToken", value: "Bearer " + token.refresh_token)
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
    
    func getLectureCount(token: Token)  {
        self.isLoading = true
        let url = "https://api.hangang.in/user/lecture"
        
        AF.request(url,
                   method: .get,
                   parameters: ["":""],
                   encoder: URLEncodedFormParameterEncoder.default,
                   headers: [
                    .authorization("Bearer " + token.access_token),
                    HTTPHeader(
                    name: "RefreshToken", value: "Bearer " + token.refresh_token)
                   ]
        ).responseDecodable { [weak self] (response: DataResponse<LectureCount, AFError>) in
            guard let weakSelf = self else { return }
                        
            guard let response = weakSelf.handleResponse(response) as? LectureCount else {
                weakSelf.isLoading = false
                            return
                        }
            weakSelf.isLoading = false
            weakSelf.myLectureCount = response
        }
    }
    
    func getPointList(token: Token)  {
        self.isLoading = true
        let url = "https://api.hangang.in/user/point"
        
        AF.request(url,
                   method: .get,
                   parameters: ["":""],
                   encoder: URLEncodedFormParameterEncoder.default,
                   headers: [
                    .authorization("Bearer " + token.access_token),
                    HTTPHeader(
                    name: "RefreshToken", value: "Bearer " + token.refresh_token)
                   ]
        ).responseDecodable { [weak self] (response: DataResponse<[Point], AFError>) in
            guard let weakSelf = self else { return }
                        
            guard let response = weakSelf.handleResponse(response) as? [Point] else {
                weakSelf.isLoading = false
                            return
                        }
            weakSelf.isLoading = false
            weakSelf.pointList = response
        }
    }
    
}
