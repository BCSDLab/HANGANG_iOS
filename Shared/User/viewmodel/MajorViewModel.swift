//
//  MajorViewModel.swift
//  hangang (iOS)
//
//  Created by 정태훈 on 2021/01/17.
//

import Foundation
import Combine

class MajorViewModel: ObservableObject, Identifiable {
    @Published var selectedMajor: [String] = []
    var email: String
    var password: String
    var nickname: String
    @Published var showDialog: Bool = false
    
    @Published var signUpResult: HangangResponse = HangangResponse() {
        didSet{
            if(signUpResult.httpStatus == "OK") {
                showDialog = true
            }
        }
    }

    
    
    var majorHandler: MajorHandler = MajorHandler()
    
    private var disposables: Set<AnyCancellable> = []
    
    
    private var isSignUpPublisher: AnyPublisher<HangangResponse, Never> {
        majorHandler.$signUpResponse
                .receive(on: RunLoop.main)
                .map { $0 }
            .eraseToAnyPublisher()
        }
    
    
    init(email: String, password: String, nickname: String) {
        
        self.email = email
        self.password = password
        self.nickname = nickname
                
        isSignUpPublisher
                    .receive(on: RunLoop.main)
                    .assign(to: \.signUpResult, on: self)
                    .store(in: &disposables)

        
    }
    
    func signUp() {
        majorHandler.signUp(email: self.email, password: self.password, nickname: self.nickname, major: self.selectedMajor)
    }

    
}
