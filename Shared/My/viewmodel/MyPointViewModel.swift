//
//  MyPointViewModel.swift
//  hangang (iOS)
//
//  Created by 정태훈 on 2021/05/23.
//

import Foundation
import Combine

class MyPointViewModel: ObservableObject, Identifiable {

    @Published var pointList: [Point]? = []
    
    var myHandler: MyHandler = MyHandler()
    
    private var disposables: Set<AnyCancellable> = []
    
    private var pointPublisher: AnyPublisher<[Point]?, Never> {
        return myHandler.$pointList
                .receive(on: RunLoop.main)
                .map { $0 }
            .eraseToAnyPublisher()
        }
    
    
    init() {
        pointPublisher
                    .receive(on: RunLoop.main)
                    .assign(to: \.pointList, on: self)
                    .store(in: &disposables)
        
        myHandler.getPointList()
    }
    
    
}
