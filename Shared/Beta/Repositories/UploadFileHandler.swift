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
    @Published var uploadFileResponse: [String] = []
    @Published var uploadImageResponse: String? = nil
    
    func uploadLectureBankFiles(fileUrls: [URL])  {
        let url = "https://api.hangang.in/lecture-banks/files"

        AF.upload(
                multipartFormData: { (multipartFormData) in
                    fileUrls.forEach { fileUrl in
                        do {
                            let attr = try FileManager.default.attributesOfItem(atPath: fileUrl.path)
                            let fileName = attr[FileAttributeKey.size]
                            let type = attr[FileAttributeKey.type]
                            multipartFormData.append(fileUrl, withName: "files", fileName: "\(fileName)", mimeType: "\(type)")
                        } catch (let error) {
                            print(error)
                        }
                    }
                    //return multipartFormData
                },
                to: url
        ).responseDecodable { [weak self] (response: DataResponse<[String], AFError>) in
            guard let weakSelf = self else { return }
            guard let response = weakSelf.handleResponse(response) as? [String] else {
                return
            }
            weakSelf.uploadFileResponse = response
        }
    }

    func uploadLectureBankImages(images: [UIImage])  {

        do {

            let url = "https://api.hangang.in/lecture-banks/files"

            AF.upload(
                    multipartFormData: { (multipartFormData) in
                        images.forEach { image in
                            let imgData = image.jpegData(compressionQuality: 0.5)
                            multipartFormData.append(imgData!, withName: "files")
                        }
                        //return multipartFormData
                    },
                    to: url
            ).responseDecodable { [weak self] (response: DataResponse<[String], AFError>) in
                guard let weakSelf = self else { return }
                guard let response = weakSelf.handleResponse(response) as? [String] else {
                    return
                }
                weakSelf.uploadFileResponse = response
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