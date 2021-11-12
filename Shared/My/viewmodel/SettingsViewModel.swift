//
//  SettingsViewModel.swift
//  hangang (iOS)
//
//  Created by 정태훈 on 2021/03/14.
//

import Foundation
import Combine

class SettingsViewModel: ObservableObject, Identifiable {
    @Published var isAuthLoggedIn: Bool = false {
        didSet{
            if(isAuthLoggedIn) {
                UserDefaults.standard.set(true, forKey:"is_auth_logged_in")
            } else {
                UserDefaults.standard.set(false, forKey:"is_auth_logged_in")
            }
        }
    }

    
    //var myHandler: MyHandler = MyHandler()
    
    private var disposables: Set<AnyCancellable> = []
    
    /*private var myPublisher: AnyPublisher<User?, Never> {
        return myHandler.$myResponse
                .receive(on: RunLoop.main)
            .print()
                .map { $0 }
            .print()
            .eraseToAnyPublisher()
        }*/
    
    init() {

        if(UserDefaults.standard.bool(forKey: "is_auth_logged_in")) {
            isAuthLoggedIn = true
        }
        /*myPublisher
                    .receive(on: RunLoop.main)
                    .assign(to: \.user, on: self)
                    .store(in: &disposables)*/
    }
    
    
}
