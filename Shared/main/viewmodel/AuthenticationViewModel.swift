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
            if(token.access_token != "") {
                tokenTest(token: token)
            }
        }
    }
    @Published var result: String = "" {
        didSet {
            /*if(result == "UNAUTHORIZED") {
                refreshToken(token: self.token)
            }*/
        }
    }
    @Published var user: User? = nil

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
    
    private var refreshTokenPublisher: AnyPublisher<Token, Never> {
        authenticationHandler.$refreshTokenResponse
                .receive(on: RunLoop.main)
                .map { $0 ?? Token()}
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
        
        refreshTokenPublisher
                .receive(on: RunLoop.main)
                .assign(to: \.token, on: self)
                .store(in: &disposables)

        let accessToken = UserDefaults.standard.string(forKey: "access_token")
        print("accessToken: \(accessToken)")
        let refreshToken = UserDefaults.standard.string(forKey: "refresh_token")
        print("refreshToken: \(refreshToken)")
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
    
    /*func refreshToken(token: Token) {
        authenticationHandler.refreshToken(token: token)
    }*/
    
    func logout() {
        self.result = ""
        self.token = Token()
        deleteToken()
    }
    
    func saveToken() {
        print("SaveToken")
        print(self.token.access_token)
        print(self.token.refresh_token)
        UserDefaults.standard.set(self.token.access_token, forKey: "access_token")
        UserDefaults.standard.set(self.token.refresh_token, forKey: "refresh_token")
    }
    
    
    
    func deleteToken() {
        print("DeleteToken")
        UserDefaults.standard.removeObject(forKey: "access_token")
        UserDefaults.standard.removeObject(forKey: "refresh_token")
    }

}
