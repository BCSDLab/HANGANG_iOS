//
//  LoginViewModel.swift
//  hangang (iOS)
//
//  Created by 정태훈 on 2021/01/10.
//

import Foundation
import Combine
import LocalAuthentication

class LoginViewModel: ObservableObject, Identifiable {
    @Published var email: String = ""
    @Published var password: String = ""
    
    @Published var loginResult: Token? = nil {
        didSet{
            if(loginResult != nil) {
                tokenChange.send(loginResult!)
            }
        }
    }
    @Published var isLoading: Bool = false

    let tokenChange = PassthroughSubject<Token, Never>()
    
    var loginHandler: LoginHandler = LoginHandler()
    
    private var disposables: Set<AnyCancellable> = []
    
    
    private var loginPublisher: AnyPublisher<Token?, Never> {
        loginHandler.$loginResponse
            .receive(on: RunLoop.main)
            .map { $0 }
                .print()
            .eraseToAnyPublisher()
        }

    private var isLoadingPublisher: AnyPublisher<Bool, Never> {
        loginHandler.$isLoading
                .receive(on: RunLoop.main)
                .map { $0 }
                .eraseToAnyPublisher()
    }
    
    init() {

        loginPublisher
                    .receive(on: RunLoop.main)
                    .assign(to: \.loginResult, on: self)
                    .store(in: &disposables)

        isLoadingPublisher
                    .receive(on: RunLoop.main)
                    .assign(to: \.isLoading, on: self)
                    .store(in: &disposables)
    }
    
    func login() {
        loginHandler.login(email: email, password: password)
    }
}

