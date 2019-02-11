//
//  SignInViewController.swift
//  stock-ios
//
//  Created by Maxim Skorynin on 06/02/2019.
//  Copyright © 2019 Maxim Skorynin. All rights reserved.
//

import Foundation
import UIKit

class SignInViewController: AppViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setLayoutOptions() {
        self.title = "Авторизация"
        self.view.setBackground(name: "StartBackground")
    }
}
