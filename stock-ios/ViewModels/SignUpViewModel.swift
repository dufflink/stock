//
//  SignUpViewModel.swift
//  stock-ios
//
//  Created by Maxim Skorynin on 09/02/2019.
//  Copyright © 2019 Maxim Skorynin. All rights reserved.
//

import Foundation
import RxSwift

protocol ValidationViewModelProtocol {
    var isCorrect : BehaviorSubject<Bool> { get set }
    var data : BehaviorSubject<String> {get set}
}

class ValidationViewModel: ValidationViewModelProtocol {
    
    let dispouseBag = DisposeBag()
    
    var isCorrect = BehaviorSubject<Bool>(value: false)
    
    var data = BehaviorSubject<String>(value: "")
    
}

class LoginViewModel : ValidationViewModel {
    override init() {
        super.init()
        data.subscribe(onNext: {
            self.isCorrect.onNext(!Utils.validateLogin($0))
        }).disposed(by: dispouseBag)
    }
}

class EmailViewModel : ValidationViewModel {
    override init() {
        super.init()
        data.subscribe(onNext: {
            self.isCorrect.onNext(!Utils.validateEmail($0))
        }).disposed(by: dispouseBag)
    }
}

class PassowrdViewModel : ValidationViewModel {
    
    var repeatPassword = BehaviorSubject<String>(value: "")
    var repeatPasswordIsCorrect = BehaviorSubject<Bool>(value: true)
    
    override init() {
        super.init()
        
        data.subscribe(onNext: {
            self.isCorrect.onNext(!Utils.validatePassword($0))
            if !$0.isEmpty {
               self.repeatPasswordIsCorrect.onNext(!Utils.validateRepeatPassword(try! self.repeatPassword.value(), $0))
            }
        }).disposed(by: dispouseBag)
        
        repeatPassword.subscribe(onNext: {
            if !$0.isEmpty {
                self.repeatPasswordIsCorrect.onNext(!Utils.validateRepeatPassword($0, try! self.data.value()))
            }
        }).disposed(by: self.dispouseBag)
    }
    
}

class SignUpViewModel {
    
    let dispouseBag = DisposeBag()
    
    let signUpData = SignUpData()
    let loginViewModel = LoginViewModel()
    let emailViewModel = EmailViewModel()
    let passwordViewModel = PassowrdViewModel()
    
    var result = BehaviorSubject<ResultApiCall>(value: .errorEncode)
    var isLoading = BehaviorSubject<Bool>(value: false)
    
    func validateInfo() -> Bool {
        let abc = Observable.combineLatest(loginViewModel.isCorrect, emailViewModel.isCorrect, passwordViewModel.isCorrect, passwordViewModel.repeatPasswordIsCorrect) {(loginBool,emailBool,passBool,repeatPassBool) in

            return !loginBool && !emailBool && !passBool && !repeatPassBool
        }
        var valid = false
        abc.subscribe(onNext: {
            valid = $0
        }).disposed(by: dispouseBag)
        print("valid \(valid)")
        return valid
    }
    
    func signUp() {
        
        let login = try! loginViewModel.data.value()
        let email = try! emailViewModel.data.value()
        let password = try! passwordViewModel.data.value()
    
        signUpData.params = SignUpParams(login: login, email: email, password: password)
        self.isLoading.onNext(true)
        Api.shared.signUp(info: signUpData) { result in
            self.isLoading.onNext(false)
            self.result.onNext(result)
        }
        print("Go reg")
        print(signUpData)

    }
}
