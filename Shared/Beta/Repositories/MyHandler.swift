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
    @Published var myLectureCount: LectureCount? = nil
    @Published var pointList: [Point] = []
    @Published var scrapLectureList: [Lecture] = []
    @Published var scrapLectureBankList: [ScrapLectureBank] = []
    @Published var myReviewList: [Review] = []
    @Published var myPurchaseList: [Purchase] = []
    @Published var isLoading = false

    func getLectureCount()  {
        self.isLoading = true
        let url = "https://api.hangang.in/user/lecture"

        let accessToken = UserDefaults.standard.string(forKey: "access_token")
        
        AF.request(url,
                   method: .get,
                   headers: [
                    .authorization("Bearer " + (accessToken ?? ""))
                   ]
        ).responseDecodable { [weak self] (response: DataResponse<LectureCount?, AFError>) in
            guard let weakSelf = self else { return }
                        
            guard let response = weakSelf.handleResponse(response) as? LectureCount? else {
                weakSelf.isLoading = false
                            return
                        }
            weakSelf.isLoading = false
            weakSelf.myLectureCount = response
        }
    }
    
    func getPointList()  {
        self.isLoading = true
        let url = "https://api.hangang.in/user/point"

        let accessToken = UserDefaults.standard.string(forKey: "access_token")
        
        AF.request(url,
                   method: .get,
                   headers: [
                    .authorization("Bearer " + (accessToken ?? ""))
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

    func getPurchaseList()  {
        self.isLoading = true
        let url = "https://api.hangang.in/user/purchase"

        let accessToken = UserDefaults.standard.string(forKey: "access_token")

        AF.request(url,
                method: .get,
                headers: [
                    .authorization("Bearer " + (accessToken ?? ""))
                ]
        ).responseDecodable { [weak self] (response: DataResponse<[Purchase], AFError>) in
            guard let weakSelf = self else { return }

            guard let response = weakSelf.handleResponse(response) as? [Purchase] else {
                weakSelf.isLoading = false
                return
            }
            weakSelf.isLoading = false
            weakSelf.myPurchaseList = response
        }
    }

    func getScrapLectureList()  {
        self.isLoading = true
        let url = "https://api.hangang.in/scrap/lecture"

        let accessToken = UserDefaults.standard.string(forKey: "access_token")

        AF.request(url,
                method: .get,
                headers: [
                    .authorization("Bearer " + (accessToken ?? ""))
                ]
        ).responseDecodable { [weak self] (response: DataResponse<[Lecture], AFError>) in
            guard let weakSelf = self else { return }

            guard let response = weakSelf.handleResponse(response) as? [Lecture] else {
                weakSelf.isLoading = false
                return
            }
            weakSelf.isLoading = false
            weakSelf.scrapLectureList = response
        }
    }

    func getScrapLectureBankList()  {
        self.isLoading = true
        let url = "https://api.hangang.in/lecture-banks/scrap"
        print(url)
        let accessToken = UserDefaults.standard.string(forKey: "access_token")

        AF.request(url,
                method: .get,
                headers: [
                    .authorization("Bearer " + (accessToken ?? ""))
                ]
        ).responseDecodable { [weak self] (response: DataResponse<[ScrapLectureBank], AFError>) in
            guard let weakSelf = self else { return }
            print(response)

            guard let response = weakSelf.handleResponse(response) as? [ScrapLectureBank] else {
                weakSelf.isLoading = false
                return
            }
            weakSelf.isLoading = false
            weakSelf.scrapLectureBankList = response
        }
    }

    func getMyReviewList()  {
        self.isLoading = true
        let url = "https://api.hangang.in/user/review"

        let accessToken = UserDefaults.standard.string(forKey: "access_token")

        AF.request(url,
                method: .get,
                parameters: ["":""],
                encoder: URLEncodedFormParameterEncoder.default,
                headers: [
                    .authorization("Bearer " + (accessToken ?? ""))
                ]
        ).responseDecodable { [weak self] (response: DataResponse<[Review], AFError>) in
            guard let weakSelf = self else { return }

            guard let response = weakSelf.handleResponse(response) as? [Review] else {
                weakSelf.isLoading = false
                return
            }
            weakSelf.isLoading = false
            weakSelf.myReviewList = response
        }
    }
}
