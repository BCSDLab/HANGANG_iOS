//
//  hangangApp.swift
//  Shared
//
//  Created by 정태훈 on 2020/12/25.
//

import SwiftUI
import Firebase
import PartialSheet

@main
struct hangangApp: App {
    @ObservedObject var authenticationViewModel: AuthenticationViewModel
    let sheetManager: PartialSheetManager = PartialSheetManager()
    
    
    init() {
        FirebaseApp.configure()
        self.authenticationViewModel = AuthenticationViewModel()
        
    }
    
    var body: some Scene {
        WindowGroup {
            if(authenticationViewModel.result == "OK") {
                ContentView()
                    .environmentObject(authenticationViewModel)
                    .environmentObject(sheetManager)
                
            } else if(authenticationViewModel.isLoading) {
                ProgressView()
            } else {
                LoginView().environmentObject(authenticationViewModel)
            }
        }
    }
}
