//
//  SignUpViewController.swift
//  stock-ios
//
//  Created by Maxim Skorynin on 06/02/2019.
//  Copyright © 2019 Maxim Skorynin. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift
import MBProgressHUD

class SignUpViewController : AppViewController {
    
    @IBOutlet weak var repeatPasswordCheck: UIImageView!
    @IBOutlet weak var passwordCheck: UIImageView!
    @IBOutlet weak var emailCheck: UIImageView!
    @IBOutlet weak var loginCheck: UIImageView!
    @IBOutlet weak var login: UITextField!
    
    @IBOutlet weak var repeatPassword: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var signUp: UIBarButtonItem!
    
    let signUpViewModel = SignUpViewModel()
    
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindingViewModel()
        setCallBack()
    }
    
    func bindingViewModel() {
        login.rx.text
            .throttle(0.3, scheduler: MainScheduler.instance)
            .bind(onNext: {
                self.signUpViewModel.loginViewModel.data.onNext($0!)
            }).disposed(by: bag)
        
        email.rx.text
            .throttle(0.3, scheduler: MainScheduler.instance)
            .bind(onNext: {
                self.signUpViewModel.emailViewModel.data.onNext($0!)
            }).disposed(by: bag)
        
        password.rx.text
            .throttle(0.3, scheduler: MainScheduler.instance)
            .bind(onNext: {
                self.signUpViewModel.passwordViewModel.data.onNext($0!)
            }).disposed(by: bag)
        
        repeatPassword.rx.text
            .throttle(0.3, scheduler: MainScheduler.instance)
            .bind(onNext: {
                self.signUpViewModel.passwordViewModel.repeatPassword.onNext($0!)
            }).disposed(by: bag)
        
        signUpViewModel.loginViewModel.isCorrect.bind(to: loginCheck.rx.isHidden).disposed(by: bag)
        signUpViewModel.emailViewModel.isCorrect.bind(to: emailCheck.rx.isHidden).disposed(by: bag)
        signUpViewModel.passwordViewModel.isCorrect.bind(to: passwordCheck.rx.isHidden).disposed(by: bag)
        signUpViewModel.passwordViewModel.repeatPasswordIsCorrect.bind(to: repeatPasswordCheck.rx.isHidden).disposed(by: bag)
        
        signUp.rx.tap
            .throttle(0.5, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [unowned self] in
            if self.signUpViewModel.validateInfo() {
                self.signUpViewModel.signUp()
            } else {
                self.showAlertOk(title: "Регистрация", message: "Заполните корректно все поля")
            }
        }).disposed(by: bag)
        
        signUpViewModel.isLoading
            .subscribeOn(SerialDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { value in
                if value {
                    self.showHud()
                } else {
                    self.hideHud()
                }
            }).disposed(by: bag)
    }
    
    func popBackViewController() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setCallBack() {
        signUpViewModel.result.asObserver()
            .skip(1)
            .bind { value in
            switch value {
            case .isSuccess:
                self.showAlertOkWithAction(title: "Поздравляем!", message: "Регистрация прошла успешно! Проверьте вашу электронную почту и подтвердите аккаунт", action: self.popBackViewController)
            case .errorDecode, .errorRequst, .errorEncode:
                self.showAlertOk(title: "Извинте", message: "Во время регистрации произошла ошибка, повторите попытку еще раз")
            case .isFailure(let code):
                switch code {
                case 1: self.showAlertOk(title: "Ошибка регистрации", message: "Такой логин уже занят")
                case 2: self.showAlertOk(title: "Ошибка регистрации", message: "Такой адрес электронной почты уже занят")
                default: self.showAlertOk(title: "Извинте", message: "Во время регистрации произошла ошибка, повторите попытку еще раз")
                }
            }
        }.disposed(by: bag)
    }
    
    override func setLayoutOptions() {
        self.title = "Регистрация"
        self.view.backgroundColor = UIColor.AppColor.Gray.grayLight
    }
}
