//
//  AuthenticationViewModel.swift
//  hangang (iOS)
//
//  Created by 정태훈 on 2021/01/01.
//

import Foundation
import Combine

class AuthenticationViewModel: ObservableObject, Identifiable {
    @Published var token: String = ""
    
    private var disposables: Set<AnyCancellable> = []
    
    
}
