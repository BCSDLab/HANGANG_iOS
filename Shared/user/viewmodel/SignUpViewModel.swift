//
//  SignUpViewModel.swift
//  hangang (iOS)
//
//  Created by 정태훈 on 2021/01/17.
//

import Foundation
import Combine

class SignUpViewModel: ObservableObject, Identifiable {
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
    @Published var nickname: String = ""
    @Published var checkPassword: Bool = false
    @Published var checkValidPassword: Bool = false
    @Published var showPassword: Bool = false
    @Published var showValidPassword: Bool = false
    @Published var allChecked: Bool = false
    var email: String
    
    let FILTERPASSWORD = "^.*(?=^.{6,18}$)(?=.*\\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$"
    
    @Published var signUpResult: HangangResponse = HangangResponse()
    @Published var nicknameCheckResult: HangangResponse = HangangResponse()
    
    
    var signUpHandler: SignUpHandler = SignUpHandler()
    
    private var disposables: Set<AnyCancellable> = []
    
    
    private var checkNicknamePublisher: AnyPublisher<HangangResponse, Never> {
        signUpHandler.$nicknameCheckResponse
                .receive(on: RunLoop.main)
            .print()
                .map { $0 }
            .print()
            .eraseToAnyPublisher()
        }
    
    init(email: String) {
        
        self.email = email
        
        checkNicknamePublisher
                    .receive(on: RunLoop.main)
                    .assign(to: \.nicknameCheckResult, on: self)
                    .store(in: &disposables)
        
    }
    
    func checkNickname() {
        signUpHandler.checkNickname(nickname: self.nickname)
    }
    
    func checkSignUp() {
        allChecked = self.checkPassword && self.checkValidPassword && (self.nicknameCheckResult.message ?? "") == "사용 가능한 닉네임입니다."
    }
    
}
