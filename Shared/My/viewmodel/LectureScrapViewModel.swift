//
// Created by 정태훈 on 2021/07/12.
//

import Foundation
import Combine

class LectureScrapViewModel: ObservableObject, Identifiable {

    @Published var token: Token? = nil
    @Published var scrapLectureList: [Lecture]? = nil

    var myHandler: MyHandler = MyHandler()

    private var disposables: Set<AnyCancellable> = []

    private var scrapLecturePublisher: AnyPublisher<[Lecture]?, Never> {
        return myHandler.$scrapLectureList
                .receive(on: RunLoop.main)
                .print()
                .map { $0 }
                .print()
                .eraseToAnyPublisher()
    }


    init(token: Token?) {
        self.token = token
        scrapLecturePublisher
                .receive(on: RunLoop.main)
                .assign(to: \.scrapLectureList, on: self)
                .store(in: &disposables)

        myHandler.getScrapLectureList(token: token)
    }


}
