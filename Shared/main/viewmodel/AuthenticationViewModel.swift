//
//  AuthenticationViewModel.swift
//  hangang (iOS)
//
//  Created by 정태훈 on 2021/01/01.
//

import Foundation
import Combine
import SwiftUI

class AuthenticationViewModel: ObservableObject, Identifiable {
    @Published var isLoading: Bool = true
    @Published var token: Token = Token() {
        didSet {
            print(token.access_token)
            tokenTest(token: token)
        }
    }
    @Published var result: String = ""

    var authenticationHandler: AuthenticationHandler = AuthenticationHandler()

    private var disposables: Set<AnyCancellable> = []

    private var checkTokenPublisher: AnyPublisher<String, Never> {
        authenticationHandler.$tokenTestResponse
                .receive(on: RunLoop.main)
                .map { response in
                    guard let response = response else {
                        return ""
                    }

                    print(response.httpStatus)

                    return response.httpStatus ?? ""
                }
                .eraseToAnyPublisher()
    }

    private var isLoadingPublisher: AnyPublisher<Bool, Never> {
        authenticationHandler.$isLoading
                .receive(on: RunLoop.main)
                .map { $0 }
                .eraseToAnyPublisher()
    }

    init() {

        isLoadingPublisher
                .receive(on: RunLoop.main)
                .assign(to: \.isLoading, on: self)
                .store(in: &disposables)

        checkTokenPublisher
                .receive(on: RunLoop.main)
                .assign(to: \.result, on: self)
                .store(in: &disposables)

        let accessToken = UserDefaults.standard.string(forKey: "access_token")
        let refreshToken = UserDefaults.standard.string(forKey: "refresh_token")
        token = Token(
                refresh_token: refreshToken ?? "",
                access_token: accessToken ?? ""
        )

    }
    
    init(result: String) {
        self.result = result
    }

    func tokenTest(token: Token) {
        authenticationHandler.testToken(token: token)
    }

}
