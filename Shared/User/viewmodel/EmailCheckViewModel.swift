//
//  EmailCheckViewModel.swift
//  hangang (iOS)
//
//  Created by 정태훈 on 2021/01/17.
//

import Foundation
import Combine

class EmailCheckViewModel: ObservableObject, Identifiable {
    @Published var email: String = ""
    @Published var secret: String = ""
    
    @Published var emailSendResult: HangangResponse = HangangResponse()
    @Published var emailCheckResult: HangangResponse = HangangResponse()
    
    var emailHandler: EmailCheckHandler = EmailCheckHandler()
    
    private var disposables: Set<AnyCancellable> = []
    
    
    private var isEmailSendPublisher: AnyPublisher<HangangResponse, Never> {
        emailHandler.$emailSendResponse
                .receive(on: RunLoop.main)
            .print()
                .map { $0 }
            .print()
            .eraseToAnyPublisher()
        }
    
    private var isEmailCheckPublisher: AnyPublisher<HangangResponse, Never> {
        emailHandler.$emailCheckResponse
                .receive(on: RunLoop.main)
            .print()
                .map { $0 }
            .print()
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
