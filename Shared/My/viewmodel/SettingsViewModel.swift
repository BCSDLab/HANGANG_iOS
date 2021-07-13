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
                UserDefaults.standard.set((self.token?.access_token ?? ""), forKey: "access_token")
                UserDefaults.standard.set((self.token?.refresh_token ?? ""), forKey: "refresh_token")
            } else {
                UserDefaults.standard.removeObject(forKey: "access_token")
                UserDefaults.standard.removeObject(forKey: "refresh_token")
            }
        }
    }
    
    
    var token: Token? = nil
    @Published var user: User? = nil
    
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
    
    init(token: Token?) {
        self.token = token

        if(UserDefaults.standard.string(forKey: "access_token") != nil) {
            isAuthLoggedIn = true
        }
        /*myPublisher
                    .receive(on: RunLoop.main)
                    .assign(to: \.user, on: self)
                    .store(in: &disposables)*/
    }

    func getMy(user: User?) {
        self.user = user
    }
    
    
}
