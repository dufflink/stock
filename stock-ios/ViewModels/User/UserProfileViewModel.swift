//
//  UserProfileViewModel.swift
//  stock-ios
//
//  Created by Maxim Skorynin on 15/02/2019.
//  Copyright © 2019 Maxim Skorynin. All rights reserved.
//

import Foundation
import RxSwift

class UserInfoViewModel {
    let dispouseBag = DisposeBag()
    let getUserInfoData = GetUserInfoData()
    var isLoading = BehaviorSubject<Bool>(value: false)
    var result = BehaviorSubject<ResultApiCall>(value: .errorEncode)

    func getUserInfo() {
        self.isLoading.onNext(true)
        getUserInfoData.params = IdParams(id: User.shared.id)
        Api.shared.getUserInfo(info: getUserInfoData) { result in
            self.isLoading.onNext(false)
            self.result.onNext(result)
        }
    }
}

class UserProfileViewModel {
    
    let userInfoViewModel = UserInfoViewModel()
    let getUserStatData = GetUserStatData()
    
    var isLoading = BehaviorSubject<Bool>(value: false)
    
    var attendedStats = PublishSubject<[AttendedCompanyData]>()
    
    func getUserStat() {
        self.isLoading.onNext(true)
        getUserStatData.params = IdParams(id: User.shared.id)
        Api.shared.getUserStat(info: getUserStatData) { result in
            self.isLoading.onNext(false)
            switch result {
            case .isSuccess:
                
                break
            case .errorDecode, .errorRequst, .errorEncode, .isFailure(_), .noInternetConnection:
                break
            }
        }
    }
    
    func getCompanyById() {
        
    }
}
