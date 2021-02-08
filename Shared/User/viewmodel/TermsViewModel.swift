//
//  TermsViewModel.swift
//  hangang (iOS)
//
//  Created by 정태훈 on 2021/01/17.
//

import Foundation
import Combine

class TermsViewModel: ObservableObject, Identifiable {
    @Published var all: Bool = false {
        didSet{
            if(all) {
                self.privacy = true
                self.hangang = true
            }
        }
    }
    
    @Published var privacy: Bool = false
    @Published var hangang: Bool = false
    
    
    
    private var disposables: Set<AnyCancellable> = []
    
    
}
