//
//  ChangePasswordViewModel.swift
//  hangang (iOS)
//
//  Created by 정태훈 on 2021/02/22.
//

import Foundation
import Combine

class ChangePasswordViewModel: ObservableObject, Identifiable {
    @Published var password: String = "" {
        didSet{
            if (checkRegex(target: password, pattern: self.FILTERPASSWORD)) {
                checkPassword = true
            } else {
                checkPassword = false
            }
        }
    }
    @Published var validPassword: String = ""{
        didSet{
            if (password == validPassword) {
                checkValidPassword = true
            } else {
                checkValidPassword = false
            }
        }
    }
    @Published var checkPassword: Bool = false
    @Published var checkValidPassword: Bool = false
    @Published var showPassword: Bool = false
    @Published var showValidPassword: Bool = false
    @Published var showDialog: Bool = false
    
    var email: String
    
    @Published var changePasswordResult: HangangResponse = HangangResponse() {
        didSet{
            if(changePasswordResult.httpStatus == "OK") {
                showDialog = true
            }
        }
    }
    
    private var isChangePasswordPublisher: AnyPublisher<HangangResponse, Never> {
        changePasswordHandler.$changePasswordResponse
                .receive(on: RunLoop.main)
                .map { $0 }
            .eraseToAnyPublisher()
        }
    
    let FILTERPASSWORD = "^.*(?=^.{6,18}$)(?=.*\\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$"
    
    
    var changePasswordHandler: ChangePasswordHandler = ChangePasswordHandler()
    
    private var disposables: Set<AnyCancellable> = []
    
    init(email: String) {
        self.email = email
        isChangePasswordPublisher
                    .receive(on: RunLoop.main)
                    .assign(to: \.changePasswordResult, on: self)
                    .store(in: &disposables)
    }
    
    func changePassword() {
        changePasswordHandler.changePassword(email: self.email, password: self.password)
    }
    
    
}
