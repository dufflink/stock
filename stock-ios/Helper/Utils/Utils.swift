//
//  Utils.swift
//  stock-ios
//
//  Created by Maxim Skorynin on 09/02/2019.
//  Copyright © 2019 Maxim Skorynin. All rights reserved.
//

import Foundation

class Utils {
    public static func validateLogin(_ login:String) -> Bool {
        if login.count < 3 { return false }
        return login.matches(Regex.login)
    }
    
    public static func validatePassword(_ password:String) -> Bool {
        return password.count >= 8
    }
    
    public static func validateEmail(_ email:String) -> Bool {
        return email.matches(Regex.email)
    }
    
    public static func validateRepeatPassword(_ password:String, _ repeatPassword : String) -> Bool {
        return password == repeatPassword
    }
}
