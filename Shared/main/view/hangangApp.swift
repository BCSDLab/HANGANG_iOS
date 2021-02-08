//
//  hangangApp.swift
//  Shared
//
//  Created by 정태훈 on 2020/12/25.
//

import SwiftUI

@main
struct hangangApp: App {
    @StateObject var authenticationViewModel = AuthenticationViewModel()
    
    var body: some Scene {
        WindowGroup {
            if(authenticationViewModel.result == "OK") {
                ContentView().environmentObject(authenticationViewModel)
            } else if(authenticationViewModel.isLoading) {
                ProgressView()
            } else {
                LoginView().environmentObject(authenticationViewModel)
            }
        }
    }
}
