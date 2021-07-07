//
//  UploadLectureBankViewModel.swift
//  hangang (iOS)
//
//  Created by 정태훈 on 2021/06/28.
//

import Foundation
import Combine
import UIKit

class UploadLectureBankViewModel: ObservableObject, Identifiable {
    @Published var title: String = ""
    @Published var lectureName: String = ""
    @Published var semester: Int = 1
    @Published var semesters: [Int] = [1,2,3,4,5,6]
    @Published var assignment: String = "기출자료"
    @Published var content: String = ""
    @Published var files: [FileBank] = []
    @Published var images: [UIImage] = []
    /*@Published var uploadedFile: [[String: Any]] = [] {
        didSet {

        }
    }*/

    var uploadFileHandler: UploadFileHandler = UploadFileHandler()
    
    private var disposables: Set<AnyCancellable> = []

    private var uploadFilePublisher: AnyPublisher<String?, Never> {
        uploadFileHandler.$uploadFileResponse
                .receive(on: RunLoop.main)
                .map { $0 }
                .eraseToAnyPublisher()
    }

    private var uploadImagePublisher: AnyPublisher<String?, Never> {
        uploadFileHandler.$uploadImageResponse
                .receive(on: RunLoop.main)
                .map { $0 }
                .eraseToAnyPublisher()
    }

    
    init() {

    }

    
    func uploadFile(fileUrl: URL) {
        uploadFileHandler.uploadFile(fileUrl: fileUrl)
    }
    
    func uploadImage(image: UIImage) {
        uploadFileHandler.uploadImage(image: image)
    }
}
