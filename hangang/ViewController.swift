//
//  ViewController.swift
//  hangang
//
//  Created by 정태훈 on 2020/12/13.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let customFont = UIFont(name: "NanumSquareRoundOTFEB", size: 20) else {
            fatalError("""
                Failed to load the "NanumSquareRoundEB" font.
                Make sure the font file is included in the project and the font name is spelled correctly.
                """
            )
        }
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        let label = UILabel()
        label.textColor = UIColor.init(named: "hangang_primary_blue")
        label.text = "한강"
        label.font = customFont
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: label)
        /*
        self.navigationController?.navigationBar.tintColor = UIColor.init(named: "hangang_primary_blue")
        
        
        
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: customFont,
            NSAttributedString.Key.foregroundColor: UIColor.init(named: "hangang_primary_blue")
        ]*/
    }

}

