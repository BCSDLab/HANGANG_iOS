//
//  EditMyViewModel.swift
//  hangang (iOS)
//
//  Created by 정태훈 on 2021/05/23.
//

import Foundation
import Combine

class EditMyViewModel: ObservableObject, Identifiable {
    @Published var nickname: String = ""
    @Published var majors: [String] = []
    var email: String = ""
    @Published var name: String = ""
    @Published var nicknameCheckResult: HangangResponse = HangangResponse()
    @Published var isEdit: Bool = false
    
    
    var signUpHandler: SignUpHandler = SignUpHandler()
    
    private var disposables: Set<AnyCancellable> = []
    
    
    private var checkNicknamePublisher: AnyPublisher<HangangResponse, Never> {
        signUpHandler.$nicknameCheckResponse
                .receive(on: RunLoop.main)
                .map { $0 }
            .eraseToAnyPublisher()
        }
    
    init(email: String, name: String, nickname: String, majors: [String]) {
        self.email = email
        self.name = name
        self.nickname = nickname
        self.majors = majors
        
        checkNicknamePublisher
                    .receive(on: RunLoop.main)
                    .assign(to: \.nicknameCheckResult, on: self)
                    .store(in: &disposables)
        
    }
    
    func checkNickname() {
        signUpHandler.checkNickname(nickname: self.nickname)
    }
    
    func toggleEdit() {
        if(isEdit) {
            // 수정하기
        }
        isEdit.toggle()
    }
}
