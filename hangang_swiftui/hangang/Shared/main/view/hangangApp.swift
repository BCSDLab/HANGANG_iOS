//
//  hangangApp.swift
//  Shared
//
//  Created by 정태훈 on 2020/12/25.
//

import SwiftUI

@main
struct hangangApp: App {
    
    
    @ObservedObject var authenticationViewModel: AuthenticationViewModel
    
    init() {
        authenticationViewModel = AuthenticationViewModel()
    }
    
    var body: some Scene {
        WindowGroup {
            LoginView()
        }
    }
}
