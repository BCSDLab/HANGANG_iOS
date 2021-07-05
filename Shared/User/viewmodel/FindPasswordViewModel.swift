//
//  FindPasswordViewModel.swift
//  hangang (iOS)
//
//  Created by 정태훈 on 2021/02/21.
//

import Foundation
import Combine

class FindPasswordViewModel: ObservableObject, Identifiable {
    @Published var email: String = ""
    @Published var secret: String = ""
    
    @Published var emailSendResult: HangangResponse = HangangResponse()
    @Published var emailCheckResult: HangangResponse = HangangResponse()
    
    var emailHandler: FindPasswordHandler = FindPasswordHandler()
    
    private var disposables: Set<AnyCancellable> = []
    
    
    private var isEmailSendPublisher: AnyPublisher<HangangResponse, Never> {
        emailHandler.$emailPasswordSendResponse
                .receive(on: RunLoop.main)
                .map { $0 }
            .eraseToAnyPublisher()
        }
    
    private var isEmailCheckPublisher: AnyPublisher<HangangResponse, Never> {
        emailHandler.$emailPasswordCheckResponse
                .receive(on: RunLoop.main)
                .map { $0 }
            .eraseToAnyPublisher()
        }
    
    init() {
                
        isEmailSendPublisher
                    .receive(on: RunLoop.main)
                    .assign(to: \.emailSendResult, on: self)
                    .store(in: &disposables)
        
        isEmailCheckPublisher
                    .receive(on: RunLoop.main)
                    .assign(to: \.emailCheckResult, on: self)
                    .store(in: &disposables)
    }
    
    func sendEmail() {
        emailHandler.sendEmail(email: email)
    }
    
    func checkEmail() {
        emailHandler.checkEmail(email: email, secret: secret)
    }
}
