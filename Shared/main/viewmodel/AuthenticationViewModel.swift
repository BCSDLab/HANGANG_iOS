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

    @Published var token: Token? = nil {
        didSet(oldVal) {
            print("SetAccess = \(token?.access_token ?? "")")
            print("SetRefresh = \(token?.refresh_token ?? "")")
            if (result != "OK" && token != nil) {
                tokenTest(token: token)
            } else if((token?.access_token ?? "") == "logout") {

            } else if(oldVal != nil){
                token = oldVal
            }
        }
    }

    @Published var result: String = "" {
        didSet {
            if(result == "UNAUTHORIZED") {
                refreshToken(token: token)
            } else if(result == "OK" && (token?.access_token ?? "") != "") {
                authenticationHandler.getMy(token: token)
                saveToken()
            }
        }
    }

    @Published var user: User? = nil

    var authenticationHandler: AuthenticationHandler = AuthenticationHandler()
    //var myHandler: MyHandler = MyHandler()

    private var disposables: Set<AnyCancellable> = []

    private var myPublisher: AnyPublisher<User?, Never> {
        return authenticationHandler.$myResponse
                .receive(on: RunLoop.main)
                .map { $0 }
                .eraseToAnyPublisher()
    }

    private var checkTokenPublisher: AnyPublisher<String, Never> {
        authenticationHandler.$tokenTestResponse
                .receive(on: RunLoop.main)
                .map { $0 }
                .eraseToAnyPublisher()
    }
    
    private var refreshTokenPublisher: AnyPublisher<Token?, Never> {
        authenticationHandler.$refreshTokenResponse
                .receive(on: RunLoop.main)
                .map { $0 }
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

        myPublisher
                .receive(on: RunLoop.main)
                .assign(to: \.user, on: self)
                .store(in: &disposables)

        let accessToken = UserDefaults.standard.string(forKey: "access_token")
        print("accessToken: \(accessToken)")
        let refreshToken = UserDefaults.standard.string(forKey: "refresh_token")
        print("refreshToken: \(refreshToken)")

        let isAuthLoggedIn = UserDefaults.standard.bool(forKey: "is_auth_logged_in")
        print("isAuthLoggedIn: \(isAuthLoggedIn)")

        if(isAuthLoggedIn && accessToken != nil) {
            self.token = Token(
                    refresh_token: refreshToken ?? "",
                    access_token: accessToken ?? ""
            )
            //tokenTest(token: self.token)
        }


    }
    
    init(result: String) {
        self.result = result
    }

    func tokenTest(token: Token?) {
        authenticationHandler.testToken(token: token)
    }
    
    func refreshToken(token: Token?) {
        authenticationHandler.refreshToken(token: token)
    }
    
    func logout() {
        self.result = ""
        self.token = Token(
                refresh_token: "",
                access_token: "logout"
        )
        deleteToken()
    }
    
    func saveToken() {
        print("SaveToken")
        print(self.token?.access_token)
        print(self.token?.refresh_token)
        UserDefaults.standard.set(self.token?.access_token ?? "", forKey: "access_token")
        UserDefaults.standard.set(self.token?.refresh_token ?? "", forKey: "refresh_token")
    }
    
    
    
    func deleteToken() {
        print("DeleteToken")
        UserDefaults.standard.removeObject(forKey: "access_token")
        UserDefaults.standard.removeObject(forKey: "refresh_token")
    }

}
