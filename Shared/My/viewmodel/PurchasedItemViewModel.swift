//
// Created by 정태훈 on 2021/07/12.
//

import Foundation
import Combine

class PurchasedItemViewModel: ObservableObject, Identifiable {

    @Published var purchaseList: [Purchase] = []

    var myHandler: MyHandler = MyHandler()

    private var disposables: Set<AnyCancellable> = []

    private var PurchasePublisher: AnyPublisher<[Purchase], Never> {
        return myHandler.$myPurchaseList
                .receive(on: RunLoop.main)
                .map { $0 }
                .eraseToAnyPublisher()
    }


    init() {
        PurchasePublisher
                .receive(on: RunLoop.main)
                .assign(to: \.purchaseList, on: self)
                .store(in: &disposables)

        myHandler.getPurchaseList()
    }


}
