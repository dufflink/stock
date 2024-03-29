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

class SignInParams : Codable {
    var login : String!
    var password : String!
    var user_agent : String!
    
    init(login : String, password : String, user_agent : String) {
        self.login = login
        self.password = password
        self.user_agent = user_agent
    }
}

class SignInData: Codable {
    var params : SignInParams!
    var method = Methods.signin
}

class CheckTokenParams: Codable {
    var who : Int!
    var token : String!
    var user_agent : String!
    
    init(who : Int, token : String, user_agent : String) {
        self.who = who
        self.token = token
        self.user_agent = user_agent
    }
}

class CheckTokenData : Codable {
    var params : CheckTokenParams!
    var method = Methods.checkToken
}

class IdParams : Codable {
    var id : Int64!
    init(id :Int64) { self.id = id }
}

class GetUserInfoData : Codable {
    var params : IdParams!
    var method = Methods.getUserInfo
}

class GetUserStatData : Codable {
    var params : IdParams!
    var method = Methods.getUserStat
}

class UpdateUserProfileData : Codable {
    var params : UpdateUserProfileParams!
    var method = Methods.updateUserProfile
}

class UpdateUserProfileParams: Codable {
    var id : Int64!
    var new_name : String!
    var new_surname : String!
    var new_birthday : String!
    var new_sex : Int!
    
    init(id : Int64, new_name : String, new_surname : String, new_birthday : String, new_sex : Int) {
        self.id = id
        self.new_name = new_name
        self.new_surname = new_surname
        self.new_birthday = new_birthday
        self.new_sex = new_sex
    }
}

