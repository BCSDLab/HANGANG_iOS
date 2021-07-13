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
    var lectureHandler: LectureHandler = LectureHandler()

    @Published var title: String = ""
    @Published var lectureName: String = ""
    @Published var semester: Semester = Semester(
            id: 1,
            semester: "2019년 1학기",
            startTime: "20190201".stringToNewDate,
            isRegular: true
    )

    var semesters: [Semester] = [
        Semester(
                id: 1,
                semester: "2019년 1학기",
                startTime: "20190201".stringToNewDate,
                isRegular: true
        ),
        Semester(
                id: 2,
                semester: "2019년 2학기",
                startTime: "20190801".stringToNewDate,
                isRegular: true
        ),
        Semester(
                id: 3,
                semester: "2020년 1학기",
                startTime: "20200201".stringToNewDate,
                isRegular: true
        ),
        Semester(
                id: 4,
                semester: "2020년 2학기",
                startTime: "20200801".stringToNewDate,
                isRegular: true
        ),
        Semester(
                id: 5,
                semester: "2021년 1학기",
                startTime: "20210201".stringToNewDate,
                isRegular: true
        ),
        Semester(
                id: 6,
                semester: "2021년 여름학기",
                startTime: "20210501".stringToNewDate,
                isRegular: false
        ),
        Semester(
                id: 7,
                semester: "2021년 2학기",
                startTime: "20210801".stringToNewDate,
                isRegular: true
        ),
        Semester(
                id: 8,
                semester: "2021년 겨울학기",
                startTime: "20211101".stringToNewDate,
                isRegular: false
        ),
        Semester(
                id: 9,
                semester: "2022년 1학기",
                startTime: "20220201".stringToNewDate,
                isRegular: true
        )
    ]

    @Published var assignment: String = "기출자료"
    @Published var content: String = ""
    @Published var files: [FileBank] = []
    @Published var images: [UIImage] = []

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
