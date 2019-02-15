//
//  SignInViewController.swift
//  stock-ios
//
//  Created by Maxim Skorynin on 06/02/2019.
//  Copyright © 2019 Maxim Skorynin. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

class SignInViewController: AppViewController {
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var signIn: UIBarButtonItem!
    
    let signInViewModel = SignInViewModel()
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindingViewModel()
        setCallBack()
    }
    
    func bindingViewModel() {
        email.rx.text
            .bind(onNext: {
                self.signInViewModel.email.onNext($0!)
            }).disposed(by: bag)
        
        password.rx.text
            .bind(onNext: {
                self.signInViewModel.password.onNext($0!)
            }).disposed(by: bag)
        
        signIn.rx.tap
            .throttle(0.5, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [unowned self] in
                if self.signInViewModel.validateInfo() {
                    self.signInViewModel.signIn()
                } else {
                    self.showAlertOk(title: "Авторизация", message: "Введите адресс электронной почты и пароль")
                }
            }).disposed(by: bag)
        
        signInViewModel.isLoading
            .subscribeOn(SerialDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { value in
                if value {
                    self.view.endEditing(true)
                    self.signIn.isEnabled = false
                    self.showHud()
                } else {
                    self.signIn.isEnabled = true
                    self.hideHud()
                }
            }).disposed(by: bag)
    }
    
    func setCallBack() {
        signInViewModel.result.asObserver()
            .subscribeOn(SerialDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
            .skip(1)
            .bind { value in
                switch value {
                case .isSuccess:
                    let tabsViewController = self.storyboard?.instantiateViewController(withIdentifier: VCIdentifier.tabBarNavVC) as! UINavigationController
                    DispatchQueue.main.async {
                        self.present(tabsViewController, animated: true)
                    }
                case .errorDecode, .errorRequst, .errorEncode:
                    self.showAlertOk(title: "Извинте", message: "Во время авторизации произошла ошибка, повторите попытку еще раз")
                case .isFailure(let code):
                    switch code {
                    case 999: self.showAlertOk(title: "Ошибка авторизации", message: "Данное приложение не поддерживаем функции компании")
                    case 777: self.showAlertOk(title: "Ошибка авторизации", message: "Такой email не зарегистрирован")
                    case 888: self.showAlertOk(title: "Ошибка авторизации", message: "Прежде чем войти в аккаунт, подтвердите адрес электронной почты.")
                    case 444: self.showAlertOk(title: "Ошибка авторизации", message: "Пароль введен не верно")
                    default: self.showAlertOk(title: "Извинте", message: "Во время регистрации произошла ошибка, повторите попытку еще раз")
                    }
                case .noInternetConnection:
                    self.showAlertNoConnection()
                }
            }.disposed(by: bag)
    }
    
    override func setLayoutOptions() {
        self.title = "Авторизация"
        self.view.setBackground(name: "StartBackground")
        self.view.addEndEditingTapper()
    }
}
