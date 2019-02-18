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
    var result = BehaviorSubject<ResultApiCall>(value: .errorEncode)

    func getUserInfo() {
        getUserInfoData.params = IdParams(id: User.shared.id)
        Api.shared.getUserInfo(info: getUserInfoData) { result in
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
            switch result {
            case .isSuccess:
                guard let companyStatisctics = User.shared.companyStatistics else {
                    return
                }
                
                var attendedCompany : [AttendedCompanyData]! = []
                print("init \(attendedCompany.count)")

                for company in companyStatisctics {
                    Api.shared.getCompanyByIdForUserProfile(id: company.id) { companyData in
                        if companyData.id != nil {
                            
                            attendedCompany.append(AttendedCompanyData(companyId: companyData.id, title: companyData.title, count: String(company.entryCount), pictureUrl: companyData.pictureUrls[0], isRated: company.isRated))
                            print("appended \(attendedCompany.count)")
                            self.attendedStats.onNext(attendedCompany)

                        }
                    }
                }
                
                self.isLoading.onNext(false)
            case .errorDecode, .errorRequst, .errorEncode, .isFailure(_), .noInternetConnection:
                print("Error get user stat for Profile \(result)")
                break
            }
        }
    }
}
