//
//  TabViewModel.swift
//  hangang (iOS)
//
//  Created by 정태훈 on 2021/02/01.
//

import Foundation

class TabViewModel: ObservableObject, Identifiable {
    @Published var selectedTab = "Home"
    
}
