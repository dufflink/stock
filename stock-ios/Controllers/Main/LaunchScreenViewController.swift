//
//  ViewController.swift
//  stock-ios
//
//  Created by Maxim Skorynin on 05/02/2019.
//  Copyright © 2019 Maxim Skorynin. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LaunchScreenViewController: UIViewController {
    
    let dispouseBag = DisposeBag()
    let startAppViewModel = StartAppViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setCallBack()
        
        startAppViewModel.isLoading
            .subscribeOn(SerialDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { value in
                if value {
                    self.showHud()
                } else {
                    self.hideHud()
                }
            }).disposed(by: dispouseBag)
        
        startAppViewModel.checkToken()
    }
    
    func setTabsAsRoot() {
        self.setRootController(storyboard: self.storyboard!, vcId: VCIdentifier.tabBarNavVC)
    }
    
    func setCallBack() {
        startAppViewModel.result.asObserver()
            .subscribeOn(SerialDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
            .skip(1)
            .bind { value in
                
                print("Result set CallBack \(value)")

                switch value {
                case .isSuccess:
                    self.setRootController(storyboard: self.storyboard!,vcId: VCIdentifier.tabBarNavVC)
                case .noInternetConnection:
                    self.showAlertOkWithAction(title: "Подключение", message: "Подключение к сети отсутствует, некоторые функции могут быть не доступны", action: self.setTabsAsRoot)
                    break
                case .errorDecode, .errorEncode, .errorRequst:
                    print("Error request auto auth")
                case .isFailure(let code):
                    switch code {
                    case 0: self.showAlertOk(title: "Ошибка", message: "Не удается подключиться к серверу")
                    case 100:
                        self.setRootController(storyboard: self.storyboard!, vcId: VCIdentifier.mainNavVC)
                    default: break
                    }
                }
            }.disposed(by: dispouseBag)
    }
}

