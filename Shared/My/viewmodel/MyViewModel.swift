//
//  MyViewModel.swift
//  hangang (iOS)
//
//  Created by 정태훈 on 2021/05/16.
//

import Foundation
import Combine

class MyViewModel: ObservableObject, Identifiable {

    @Published var lectureCount: LectureCount? = nil
    @Published var purchaseList: [Purchase] = []

    var myHandler: MyHandler = MyHandler()

    private var disposables: Set<AnyCancellable> = []

    private var purchaseListPublisher: AnyPublisher<[Purchase], Never> {
        return myHandler.$myPurchaseList
                .receive(on: RunLoop.main)
                .map { $0 }
            .eraseToAnyPublisher()
        }

    private var lectureCountPublisher: AnyPublisher<LectureCount?, Never> {
        return myHandler.$myLectureCount
                .receive(on: RunLoop.main)
                .map { $0 }
                .eraseToAnyPublisher()
    }

    init() {


        lectureCountPublisher
                .receive(on: RunLoop.main)
                .assign(to: \.lectureCount, on: self)
                .store(in: &disposables)

        purchaseListPublisher
                .receive(on: RunLoop.main)
                .assign(to: \.purchaseList, on: self)
                .store(in: &disposables)

        myHandler.getLectureCount()
        myHandler.getPurchaseList()
    }
}
