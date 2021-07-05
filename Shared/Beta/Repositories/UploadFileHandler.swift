//
//  UploadFileHandler.swift
//  hangang (iOS)
//
//  Created by 정태훈 on 2021/07/03.
//
import Alamofire
import UIKit
import SwiftUI

class UploadFileHandler: APIHandler {
    /*@Published var lectureBankResponse: [LectureBank] = []
    @Published var lectureBankCommentResponse: [Comment] = []*/
    
    func uploadFile(fileUrl: URL)  {
        do {
            let attr = try FileManager.default.attributesOfItem(atPath: fileUrl.path)
            let fileName = attr[FileAttributeKey.size]
            let type = attr[FileAttributeKey.type]
        } catch (let error) {
            print(error)
        }
        /*let url = "https://api.hangang.in/lecture-banks"
        
        let data = LectureBankRequest(
            department: department,
            page: 1
        )
        
        
        AF.request(url,
                   method: .get,
                   parameters: data,
                   encoder: URLEncodedFormParameterEncoder.default
        ).responseDecodable { [weak self] (response: DataResponse<CommonResponse<LectureBank>, AFError>) in
            guard let weakSelf = self else { return }
            guard let response = weakSelf.handleResponse(response) as? CommonResponse<LectureBank> else {
                            return
                        }
            //weakSelf.lectureBankResponse = response
            weakSelf.lectureBankResponse = (response.result ?? [])
            //weakSelf.reviewCount = response.count
        }*/
    }
    
    func uploadImage(image: UIImage)  {
        let imgData = image.jpegData(compressionQuality: 0.5)
        
        
        /*let url = "https://api.hangang.in/lecture-banks"
        
        let data = LectureBankRequest(
            department: department,
            page: 1
        )
        
        
        AF.request(url,
                   method: .get,
                   parameters: data,
                   encoder: URLEncodedFormParameterEncoder.default
        ).responseDecodable { [weak self] (response: DataResponse<CommonResponse<LectureBank>, AFError>) in
            guard let weakSelf = self else { return }
            guard let response = weakSelf.handleResponse(response) as? CommonResponse<LectureBank> else {
                            return
                        }
            //weakSelf.lectureBankResponse = response
            weakSelf.lectureBankResponse = (response.result ?? [])
            //weakSelf.reviewCount = response.count
        }*/
    }
    
}
