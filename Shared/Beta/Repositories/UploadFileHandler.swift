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
    @Published var uploadFileResponse: String? = nil
    @Published var uploadImageResponse: String? = nil
    
    func uploadFile(fileUrl: URL)  {
        do {
            let attr = try FileManager.default.attributesOfItem(atPath: fileUrl.path)
            let fileName = attr[FileAttributeKey.size]
            let type = attr[FileAttributeKey.type]

            let url = "https://api.hangang.in/lecture-banks/files"

            AF.upload(
                multipartFormData: { (multipartFormData) in
                    multipartFormData.append(fileUrl, withName: "files", fileName: "\(fileName)", mimeType: "\(type)")
                    //return multipartFormData
                },
                    to: url
            ).responseDecodable { [weak self] (response: DataResponse<[String], AFError>) in
                guard let weakSelf = self else { return }
                guard let response = weakSelf.handleResponse(response) as? [String] else {
                    return
                }
                weakSelf.uploadFileResponse = response.first
            }
        } catch (let error) {
            print(error)
        }
    }
    
    func uploadImage(image: UIImage)  {
        let imgData = image.jpegData(compressionQuality: 0.5)
        do {

            let url = "https://api.hangang.in/sample/s3/file"

            AF.upload(
                    multipartFormData: { (multipartFormData) in
                        multipartFormData.append(imgData!, withName: "files")
                        //return multipartFormData
                    },
                    to: url
            ).responseDecodable { [weak self] (response: DataResponse<[String], AFError>) in
                guard let weakSelf = self else { return }
                guard let response = weakSelf.handleResponse(response) as? [String] else {
                    return
                }
                weakSelf.uploadImageResponse = response.first
            }
        } catch (let error) {
            print(error)
        }
    }
    
}
