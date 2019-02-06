//
//  UserData.swift
//  stock-ios
//
//  Created by Maxim Skorynin on 06/02/2019.
//  Copyright © 2019 Maxim Skorynin. All rights reserved.
//

import Foundation

class SignUpParams : Codable {
    var login : String!
    var email : String!
    var password : String!

    var name = ""
    var surname = ""
    var patronymic = ""
    var birthday = "1900-01-01"
    
    init(login : String, email : String, password : String) {
        self.login = login
        self.email = email
        self.password = password
    }
}

class SignUpData: Codable {
    var params : SignUpParams!
    var method = Methods.signup
}

