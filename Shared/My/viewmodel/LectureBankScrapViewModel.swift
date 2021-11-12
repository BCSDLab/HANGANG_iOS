//
// Created by 정태훈 on 2021/07/12.
//

import Foundation
import Combine

class LectureBankScrapViewModel: ObservableObject, Identifiable {
    @Published var scrapLectureBankList: [ScrapLectureBank]? = []

    var myHandler: MyHandler = MyHandler()

    private var disposables: Set<AnyCancellable> = []

    private var scrapLectureBankPublisher: AnyPublisher<[ScrapLectureBank]?, Never> {
        return myHandler.$scrapLectureBankList
                .receive(on: RunLoop.main)
                .map { $0 }
                .eraseToAnyPublisher()
    }


    init() {
        scrapLectureBankPublisher
                .receive(on: RunLoop.main)
                .assign(to: \.scrapLectureBankList, on: self)
                .store(in: &disposables)

        myHandler.getScrapLectureBankList()
    }


}