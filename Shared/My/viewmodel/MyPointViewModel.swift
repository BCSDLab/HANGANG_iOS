//
//  MyPointViewModel.swift
//  hangang (iOS)
//
//  Created by 정태훈 on 2021/05/23.
//

import Foundation
import Combine

class MyPointViewModel: ObservableObject, Identifiable {
    
    @Published var token: Token? = nil
    @Published var pointList: [Point]? = nil
    
    var myHandler: MyHandler = MyHandler()
    
    private var disposables: Set<AnyCancellable> = []
    
    private var pointPublisher: AnyPublisher<[Point]?, Never> {
        return myHandler.$pointList
                .receive(on: RunLoop.main)
            .print()
                .map { $0 }
            .print()
            .eraseToAnyPublisher()
        }
    
    
    init(token: Token) {
        self.token = token
        pointPublisher
                    .receive(on: RunLoop.main)
                    .assign(to: \.pointList, on: self)
                    .store(in: &disposables)
        
        myHandler.getPointList(token: token)
    }
    
    
}
