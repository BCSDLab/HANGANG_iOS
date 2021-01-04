//
//  UINavigationConfiguration.swift
//  hangang (iOS)
//
//  Created by 정태훈 on 2020/12/25.
//

import Foundation
import SwiftUI

struct UINavigationConfiguration: UIViewControllerRepresentable {
    var config: (UINavigationController) -> Void = {_ in }
    
    func makeUIViewController(context: Context) -> UIViewController {
        let controller = UIViewController()
        DispatchQueue.main.async {
            if let nc = controller.navigationController {
                self.config(nc)
            }
        }
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
    }
}
