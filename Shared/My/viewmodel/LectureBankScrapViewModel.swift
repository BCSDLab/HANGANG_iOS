//
// Created by 정태훈 on 2021/07/12.
//

import Foundation
import Combine

class LectureBankScrapViewModel: ObservableObject, Identifiable {

    @Published var token: Token? = nil
    @Published var scrapLectureBankList: [ScrapLectureBank]? = nil

    var myHandler: MyHandler = MyHandler()

    private var disposables: Set<AnyCancellable> = []

    private var scrapLectureBankPublisher: AnyPublisher<[ScrapLectureBank]?, Never> {
        return myHandler.$scrapLectureBankList
                .receive(on: RunLoop.main)
                .print()
                .map { $0 }
                .print()
                .eraseToAnyPublisher()
    }


    init(token: Token?) {
        self.token = token
        scrapLectureBankPublisher
                .receive(on: RunLoop.main)
                .assign(to: \.scrapLectureBankList, on: self)
                .store(in: &disposables)

        myHandler.getScrapLectureBankList(token: token)
    }


}