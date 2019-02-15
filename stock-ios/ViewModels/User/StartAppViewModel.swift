//
//  StartAppViewModel.swift
//  stock-ios
//
//  Created by Maxim Skorynin on 14/02/2019.
//  Copyright © 2019 Maxim Skorynin. All rights reserved.
//

import Foundation
import RxSwift

class StartAppViewModel {
    
    let checkTokenData = CheckTokenData()
    var result = BehaviorSubject<ResultApiCall>(value: .errorEncode)
    var isLoading = BehaviorSubject<Bool>(value: false)
    
    func checkToken() {
        self.isLoading.onNext(true)

        if User.shared.token != nil {
            let userAgent = UserAgent.shared.userAgentString()
            checkTokenData.params = CheckTokenParams(who: 2, token: User.shared.token, user_agent: userAgent)
            
            Api.shared.checkToken(info: checkTokenData) { result in
                print("Result check token \(result)")
                self.isLoading.onNext(false)
                switch result {
                case .isSuccess:
                    self.result.onNext(.isSuccess)
                case .errorDecode, .errorRequst, .errorEncode, .isFailure(_), .noInternetConnection:
                    self.result.onNext(result)
                    break
                }
            }
        } else {
            self.result.onNext(.isFailure(code: 100))
        }
    }
}
