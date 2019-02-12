//
//  SignInViewModel.swift
//  stock-ios
//
//  Created by Maxim Skorynin on 11/02/2019.
//  Copyright © 2019 Maxim Skorynin. All rights reserved.
//

import Foundation
import RxSwift

class SignInViewModel {
    let dispouseBag = DisposeBag()
    let signInData = SignInData()
    let checkTokenData = CheckTokenData()
    let getUserInfoData = GetUserInfoData()
    let getUserStatData = GetUserStatData()
    
    var result = BehaviorSubject<ResultApiCall>(value: .errorEncode)
    var isLoading = BehaviorSubject<Bool>(value: false)
    var email = BehaviorSubject<String>(value: "")
    var password = BehaviorSubject<String>(value: "")
    let userAgent = UserAgent.shared.userAgentString()
    
    func validateInfo() -> Bool {
        let login = try! self.email.value()
        let password = try! self.password.value()
        
        if login.isEmpty || password.isEmpty {
            return false
        }
        return true
    }
    
    func signIn() {
        let login = try! self.email.value()
        let password = try! self.password.value()
        signInData.params = SignInParams(login: login, password: password, user_agent: userAgent)
        self.isLoading.onNext(true)

        Api.shared.signIn(info: signInData) { result in
            self.checkResult(result: result, action: self.checkToken)
        }
    }
    
    func checkToken() {
        checkTokenData.params = CheckTokenParams(who: 2, token: User.shared.token, user_agent: userAgent)
        
        Api.shared.checkToken(info: checkTokenData) { result in
            self.checkResult(result: result, action: self.getUserInfo)
        }
    }
    
    func getUserInfo() {
        getUserInfoData.params = UserIdParams(id: User.shared.id)
        
        Api.shared.getUserInfo(info: getUserInfoData) { result in
            self.checkResult(result: result, action: self.getUserStat)
        }
    }
    
    func getUserStat() {
        getUserStatData.params = UserIdParams(id: User.shared.id)
        
        Api.shared.getUserStat(info: getUserStatData) { result in
            switch result {
            case .isSuccess:
                self.isLoading.onNext(false)
                self.result.onNext(.isSuccess)
            case .errorDecode, .errorRequst, .errorEncode, .isFailure(_):
                self.isLoading.onNext(false)
                self.result.onNext(result)
                break
            }
        }
    }
    
    func checkResult(result : ResultApiCall, action: () -> Void) {
        switch result {
        case .isSuccess:
            action()
        case .errorDecode, .errorRequst, .errorEncode, .isFailure(_):
            self.isLoading.onNext(false)
            self.result.onNext(result)
            break
        }
    }
}
