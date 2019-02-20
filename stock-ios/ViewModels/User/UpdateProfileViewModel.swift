//
//  UpdateProfileViewModel.swift
//  stock-ios
//
//  Created by Maxim Skorynin on 19/02/2019.
//  Copyright © 2019 Maxim Skorynin. All rights reserved.
//

import Foundation
import RxSwift

class UpdateProfileViewModel {
    
    var result = BehaviorSubject<ResultApiCall>(value: .errorEncode)
    
    var name = BehaviorSubject<String>(value: "")
    var surname = BehaviorSubject<String>(value: "")
    var bday = BehaviorSubject<String>(value: "")
    var sex = BehaviorSubject<Int>(value: 0)
    
    let updateUserProfileData = UpdateUserProfileData()
    

    func updateProfile() {
        let name = try! self.name.value()
        let surname = try! self.surname.value()
        let bday = try! self.bday.value()
        let sex = try! self.sex.value()
        
        if name.isEmpty || surname.isEmpty {
            self.result.onNext(.isFailure(code: 99))
            return
        }

        updateUserProfileData.params = UpdateUserProfileParams(id: User.shared.id, new_name: name, new_surname: surname, new_birthday: bday, new_sex: sex)
        
        Api.shared.updateUserProfile(info: updateUserProfileData) { result in
            
            print(result)

            switch result {
            case .isSuccess:
                User.shared.name = name
                User.shared.surname = surname
                User.shared.birthday = bday
                User.shared.sex = sex
                User.shared.saveSettings()
                
                self.result.onNext(.isSuccess)

            case .errorDecode, .errorRequst, .errorEncode, .isFailure(_), .noInternetConnection:
                self.result.onNext(result)
                break
            }
        }
        
        
    }
}
