//
//  HomeViewModel.swift
//  hangang (iOS)
//
//  Created by 정태훈 on 2021/01/01.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject, Identifiable {
    @Published var tabIndex: Int = 0
    
    private var disposables: Set<AnyCancellable> = []
    
}
