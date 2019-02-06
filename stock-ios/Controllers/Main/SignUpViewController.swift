//
//  SignUpViewController.swift
//  stock-ios
//
//  Created by Maxim Skorynin on 06/02/2019.
//  Copyright © 2019 Maxim Skorynin. All rights reserved.
//

import Foundation
import UIKit

class SignUpViewController : AppViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sign = SignUpData()
        sign.params = SignUpParams(login: "gogik1", email: "firktie1@mail.ru", password: "12345678")
        Api.shared.signUp(info: sign) { _ in
            print("signed")
        }
        
    }
    
    override func setLayoutOptions() {
        self.title = "Регистрация"
        self.view.backgroundColor = UIColor.AppColor.Gray.grayLight
    }
}
