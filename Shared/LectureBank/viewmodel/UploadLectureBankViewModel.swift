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
    @Published var selectedLecture: Lecture? = nil
    @Published var semester: Semester = Semester(
            id: 1,
            semester: "2019년 1학기",
            startTime: "20190201",
            isRegular: 1
    )

    var semesters: [Semester] = [
        Semester(
                id: 1,
                semester: "2019년 1학기",
                startTime: "20190201",
                isRegular: 1
        ),
        Semester(
                id: 2,
                semester: "2019년 2학기",
                startTime: "20190801",
                isRegular: 1
        ),
        Semester(
                id: 3,
                semester: "2020년 1학기",
                startTime: "20200201",
                isRegular: 1
        ),
        Semester(
                id: 4,
                semester: "2020년 2학기",
                startTime: "20200801",
                isRegular: 1
        ),
        Semester(
                id: 5,
                semester: "2021년 1학기",
                startTime: "20210201",
                isRegular: 1
        ),
        Semester(
                id: 6,
                semester: "2021년 여름학기",
                startTime: "20210501",
                isRegular: 0
        ),
        Semester(
                id: 7,
                semester: "2021년 2학기",
                startTime: "20210801",
                isRegular: 1
        ),
        Semester(
                id: 8,
                semester: "2021년 겨울학기",
                startTime: "20211101",
                isRegular: 0
        ),
        Semester(
                id: 9,
                semester: "2022년 1학기",
                startTime: "20220201",
                isRegular: 1
        )
    ]

    @Published var assignment: [String] = ["기출자료"]
    @Published var content: String = ""
    @Published var files: [FileBank] = []
    @Published var images: [UIImage] = []
    @Published var uploadedBanks: [String] = []

    @Published var uploadedFiles: [String] = [] {
        didSet {
            uploadedBanks.append(contentsOf: uploadedBanks)
        }
    }

    @Published var response: HangangResponse? = nil {
        didSet{
            if(response != nil) {
                responseChange.send(response!)
            }
        }
    }

    var uploadFileHandler: UploadFileHandler = UploadFileHandler()
    var lectureBankHandler: LectureBankHandler = LectureBankHandler()

    let responseChange = PassthroughSubject<HangangResponse, Never>()
    
    private var disposables: Set<AnyCancellable> = []

    private var uploadFilePublisher: AnyPublisher<[String], Never> {
        uploadFileHandler.$uploadFileResponse
                .receive(on: RunLoop.main)
                .map { $0 }
                .eraseToAnyPublisher()
    }

    private var uploadLectureBankPublisher: AnyPublisher<HangangResponse?, Never> {
        lectureBankHandler.$uploadedLectureBankResponse
                .receive(on: RunLoop.main)
                .map { $0 }
                .eraseToAnyPublisher()
    }

    
    init() {
        uploadLectureBankPublisher
                .receive(on: RunLoop.main)
                .assign(to: \.response, on: self)
                .store(in: &disposables)

        uploadFilePublisher
                .receive(on: RunLoop.main)
                .assign(to: \.uploadedFiles, on: self)
                .store(in: &disposables)
    }

    
    func uploadFiles() {
        uploadFileHandler.uploadLectureBankFiles(fileUrls: files.compactMap { $0.url!})
    }
    
    func uploadImages() {
        uploadFileHandler.uploadLectureBankImages(images: images)
    }

    func uploadLectureBank(user: User?) {
        uploadFiles()
        uploadImages()
        lectureBankHandler.uploadLectureBank(
                lectureBank: UploadLectureBankRequest(
                        category: assignment,
                        content: content,
                        files: uploadedBanks,
                        lecture_id: selectedLecture?.id ?? -1,
                        semester_id: semester.id,
                        title: title
                ))
    }
}
