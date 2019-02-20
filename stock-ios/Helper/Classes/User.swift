//
//  User.swift
//  stock-ios
//
//  Created by Maxim Skorynin on 12/02/2019.
//  Copyright © 2019 Maxim Skorynin. All rights reserved.
//

import Foundation
import SwiftyJSON

class User {
    
    static let shared = User()
    
    var id : Int64!
    var token : String!
    
    var login : String!
    var email : String!
    var name : String!
    var surname : String!
    var patronymic : String!
    var balance : String!
    var birthday : String!
    var isActivated : Bool!
    var subscribeEndTime : String!
    var sex : Int!
    var bonus : Int!
    var amountSave : Float!
    var companyStatistics : [CompanyStatistic]! {
        didSet {
            calculateAmountSave()
        }
    }
    
    func calculateAmountSave() {
        amountSave = 0
        if companyStatistics != nil {
            for stat in companyStatistics {
                amountSave += stat.amountSave
            }
        }
    }
    
    func setUser(_ userObject : JSON) {
        login = userObject["Login"].stringValue
        email = userObject["Email"].stringValue
        name = userObject["Name"].stringValue
        surname = userObject["Surname"].stringValue
        patronymic = userObject["Patronymic"].stringValue
        balance = userObject["Balance"].stringValue
        birthday = userObject["Birthday"]["String"].stringValue
        isActivated = userObject["IsActivated"].boolValue
        subscribeEndTime = userObject["SubscribeEndTime"].stringValue
        bonus = userObject["Bonus"].intValue
        sex = userObject["Sex"].intValue
        saveSettings()
    }
    
    func setCompanyStatictics(_ statisticsArray : [JSON]) {
        
        if statisticsArray.isEmpty {
            self.companyStatistics = []
            return
        }

        var companyStatistics : [CompanyStatistic]! = []

        statisticsArray.forEach {
            companyStatistics.append(CompanyStatistic(
                id: Int64($0["ID"].intValue),
                entryCount: $0["EntryCount"].intValue,
                amountSave: $0["AmountSave"].floatValue,
                isRated: $0["IsRated"].intValue))
        }
        
        self.companyStatistics = companyStatistics
    }
    
    func loadSettings() {
        let userDefault = UserDefaults.standard
        id = Int64(userDefault.integer(forKey: UserDefaultKey.id))
        token = userDefault.string(forKey: UserDefaultKey.token)
        name = userDefault.string(forKey: UserDefaultKey.name)
        surname = userDefault.string(forKey: UserDefaultKey.surname)
        patronymic = userDefault.string(forKey: UserDefaultKey.patronymic)
        balance = userDefault.string(forKey: UserDefaultKey.balance)
        birthday = userDefault.string(forKey: UserDefaultKey.birthday)
        isActivated = userDefault.bool(forKey: UserDefaultKey.isActivated)
        subscribeEndTime = userDefault.string(forKey: UserDefaultKey.subscribeEndTime)
        bonus = userDefault.integer(forKey: UserDefaultKey.bonus)
        amountSave = userDefault.float(forKey: UserDefaultKey.amountSave)
        sex = userDefault.integer(forKey: UserDefaultKey.sex)

    }
    
    func saveSettings() {
        let userDefaults = UserDefaults.standard
        userDefaults.set(id, forKey: UserDefaultKey.id)
        userDefaults.set(token, forKey: UserDefaultKey.token)
        userDefaults.set(name, forKey: UserDefaultKey.name)
        userDefaults.set(surname, forKey: UserDefaultKey.surname)
        userDefaults.set(patronymic, forKey: UserDefaultKey.patronymic)
        userDefaults.set(balance, forKey: UserDefaultKey.balance)
        userDefaults.set(birthday, forKey: UserDefaultKey.birthday)
        userDefaults.set(isActivated, forKey: UserDefaultKey.isActivated)
        userDefaults.set(subscribeEndTime, forKey: UserDefaultKey.subscribeEndTime)
        userDefaults.set(bonus, forKey: UserDefaultKey.bonus)
        userDefaults.set(amountSave, forKey: UserDefaultKey.amountSave)
        userDefaults.set(sex, forKey: UserDefaultKey.sex)
    }
    
    func setDefaultSetting() {
        id = -1
        token = nil
        name = nil
        surname = nil
        patronymic = nil
        balance = nil
        birthday = nil
        isActivated = false
        subscribeEndTime = nil
        bonus = 0
        amountSave = 0
        sex = 0
        saveSettings()
    }
}
