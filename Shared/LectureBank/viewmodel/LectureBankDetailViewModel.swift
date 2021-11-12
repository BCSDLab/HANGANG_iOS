//
//  LectureBankDetailViewModel.swift
//  hangang (iOS)
//
//  Created by 정태훈 on 2021/03/14.
//

import Foundation
import Combine

class LectureBankDetailViewModel: ObservableObject, Identifiable {
    var lectureBankId: Int
    @Published var comment: String = ""
    @Published var lectureBankResult: LectureBank? = nil
    @Published var lectureBankCommentsResult: [Comment] = []
    @Published var addCommentId: Int? = nil {
        didSet {
            getLectureBankComments(lectureBankId: lectureBankId)
        }
    }
    @Published var purchaseResult: String? = nil {
        didSet {
            if(purchaseResult == "OK") {

            }
        }
    }

    @Published var downloadLink: String? = nil {
        didSet {
            if(downloadLink != nil && !((downloadLink ?? "").isEmpty)) {
                let fileName = String(downloadLink?.split(separator: "/").last?.split(separator: "?").first ?? "")
                let documentDirectory = FileManager.default.urls(for: .documentDirectory,
                        in: .userDomainMask)[0]
                print(fileName)
                let localFileLink = documentDirectory.appendingPathComponent(fileName)

                if let imageUrl = URL(string: downloadLink ?? "") {
                    // 3
                    URLSession.shared.downloadTask(with: imageUrl) { (tempFileUrl, response, error) in

                        // 4
                        if let imageTempFileUrl = tempFileUrl {
                            do {
                                // 1
                                let imageData = try Data(contentsOf: imageTempFileUrl)

// 2
                                try imageData.write(to: localFileLink,
                                        options: [
                                            .atomic
                                        ])
                            } catch {
                                print("Error")
                            }
                        }
                    }.resume()
                }

                /*FileDownloader.loadFileAsync(url: url!) { (path, error) in
                    let tempPath = URL(string: path ?? "")
                    let documentDirectory = FileManager.default.urls(for: .documentDirectory,
                            in: .userDomainMask)[0]
                    let savePath = documentDirectory.appendingPathComponent(fileName)
                    do {
                        let imageData = try Data(contentsOf: tempPath!)
                        try imageData.write(
                                to: savePath,
                        options: [
                            .atomic
                        ]
                        )

                    } catch {
                        print(error.localizedDescription)
                    }
                }*/
            }
        }
    }
    
    var lectureBankDetailHandler: LectureBankDetailHandler = LectureBankDetailHandler()
    
    private var disposables: Set<AnyCancellable> = []
    
    private var LectureBankPublisher: AnyPublisher<LectureBank?, Never> {
        lectureBankDetailHandler.$lectureBank
                .receive(on: RunLoop.main)
                .map { $0 }
            .eraseToAnyPublisher()
        }
    
    private var LectureBankCommentPublisher: AnyPublisher<[Comment], Never> {
        lectureBankDetailHandler.$lectureBankCommentResponse
                .receive(on: RunLoop.main)
                .map { $0 }
            .eraseToAnyPublisher()
        }

    private var AddCommentPublisher: AnyPublisher<Int?, Never> {
        lectureBankDetailHandler.$addCommentId
                .receive(on: RunLoop.main)
                .map { $0 }
                .eraseToAnyPublisher()
    }

    private var PurchasePublisher: AnyPublisher<String?, Never> {
        lectureBankDetailHandler.$purchaseResult
                .receive(on: RunLoop.main)
                .map { $0 }
                .eraseToAnyPublisher()
    }

    private var DownloadLinkPublisher: AnyPublisher<String?, Never> {
        lectureBankDetailHandler.$downloadLink
                .receive(on: RunLoop.main)
                .map { $0 }
                .eraseToAnyPublisher()
    }

    private var HitLectureBankPublisher: AnyPublisher<LectureBank?, Never> {
        lectureBankDetailHandler.$hitLectureBank
                .receive(on: RunLoop.main)
                .map { $0 }
                .eraseToAnyPublisher()
    }
    
    init(lectureBankId: Int) {
        self.lectureBankId = lectureBankId
        LectureBankPublisher
                    .receive(on: RunLoop.main)
                    .assign(to: \.lectureBankResult, on: self)
                    .store(in: &disposables)

        HitLectureBankPublisher
                .receive(on: RunLoop.main)
                .assign(to: \.lectureBankResult, on: self)
                .store(in: &disposables)
        
        LectureBankCommentPublisher
                    .receive(on: RunLoop.main)
                    .assign(to: \.lectureBankCommentsResult, on: self)
                    .store(in: &disposables)

        AddCommentPublisher
                .receive(on: RunLoop.main)
                .assign(to: \.addCommentId, on: self)
                .store(in: &disposables)

        PurchasePublisher
                .receive(on: RunLoop.main)
                .assign(to: \.purchaseResult, on: self)
                .store(in: &disposables)

        DownloadLinkPublisher
                .receive(on: RunLoop.main)
                .assign(to: \.downloadLink, on: self)
                .store(in: &disposables)

        getLectureBank(lectureBankId: lectureBankId)
        getLectureBankComments(lectureBankId: lectureBankId)
    }
    
    func getLectureBank(lectureBankId: Int) {
        lectureBankDetailHandler.getLectureBank(
            lectureBankId: lectureBankId
        )
    }
    
    func getLectureBankComments(lectureBankId: Int) {
        lectureBankDetailHandler.getLectureBankComment(
            lectureBankId: lectureBankId
        )
    }

    func addComment() {
        lectureBankDetailHandler.addComment(
                lectureBankId: lectureBankId,
                comment: comment
        )

        self.comment = ""
    }

    func purchase() {
        lectureBankDetailHandler.purchaseLectureBank(
                lectureBankId: lectureBankId
        )
    }

    func hitLectureBank() {
        lectureBankDetailHandler.hitLectureBank(
                lectureBank: lectureBankResult!
        )
    }

    func downloadFile(uploadedFileId: Int) {
        print("start download")
        if(uploadedFileId != -1) {
            lectureBankDetailHandler.getDownloadLink(
                    uploadedFileId: uploadedFileId
            )
        }
    }
}
