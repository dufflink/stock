//
//  UpdateUserProfileViewController.swift
//  stock-ios
//
//  Created by Maxim Skorynin on 19/02/2019.
//  Copyright © 2019 Maxim Skorynin. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class UpdateUserProfileViewController : AppViewController {
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var surname: UITextField!
    @IBOutlet weak var bday: UITextField!
    @IBOutlet weak var sexSwitcher: UISegmentedControl!
    @IBOutlet weak var changePassword: StyleButton!
    @IBOutlet weak var save: StyleButton!
    
    var datePicker : UIDatePicker!
    var dateFormatter : DateFormatter!
    let updateProfileViewModel = UpdateProfileViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindingViewModel()
        setCallBack()
        setUserInfo()
        setDatePicker()
    }
    
    override func setLayoutOptions() {
        view.backgroundColor = UIColor.AppColor.Red.redUltraWhite
        title = "Редактирование профиля"
        self.view.addEndEditingTapper()
    }
    
    func bindingViewModel() {
        name.rx.text
            .bind(onNext: {
                self.updateProfileViewModel.name.onNext($0!)
            }).disposed(by: disposeBag)
        surname.rx.text
            .bind(onNext: {
                self.updateProfileViewModel.surname.onNext($0!)
            }).disposed(by: disposeBag)

        
        sexSwitcher.rx.value.asDriver().drive(onNext: {
            self.updateProfileViewModel.sex.onNext($0)
        }).disposed(by: disposeBag)
        
        save.rx.tap
            .throttle(0.5, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [unowned self] in
                self.updateProfileViewModel.updateProfile()
            }).disposed(by: disposeBag)
        
    }
    
    func setCallBack() {
        updateProfileViewModel.result.asObserver()
            .subscribeOn(SerialDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
            .skip(1)
            .bind { value in
                switch value {
                case .isSuccess:
                    self.showSuccesHud()
                case .errorDecode, .errorRequst, .errorEncode:
                    self.showAlertOk(title: "Извинте", message: "Во время обовления информации произошла ошибка, повторите попытку еще раз")
                case .isFailure(let code):
                    if code == 99 {
                        self.showAlertOk(title: "Ошибка", message: "Поля имени и фамилии не должны быть пустыми")
                    } else {
                        self.showAlertOk(title: "Извинте", message: "Во время обовления информации произошла ошибка, повторите попытку еще раз")
                    }
                case .noInternetConnection:
                    self.showAlertNoConnection()
                }
            }.disposed(by: disposeBag)
    }
    
    func setDatePicker() {
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(dateChanged(datePicker:)), for: .valueChanged)
        datePicker.maximumDate = Date()
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if !bday.text!.isEmpty {
            datePicker.setDate(dateFormatter.date(from: bday.text!)!, animated: false)
        }
        bday.inputView = datePicker
    }
    
    @objc func dateChanged(datePicker : UIDatePicker) {
        let newDate = dateFormatter.string(from: datePicker.date)
        bday.text = newDate
        updateProfileViewModel.bday.onNext(newDate)
    }
    
    func setUserInfo() {
        let user = User.shared
        name.text = user.name ?? ""
        surname.text = user.surname ?? ""
        bday.text = user.birthday ?? ""
        sexSwitcher.selectedSegmentIndex = user.sex
        
        updateProfileViewModel.name.onNext(user.name)
        updateProfileViewModel.surname.onNext(user.surname)
        updateProfileViewModel.bday.onNext(user.birthday)
        updateProfileViewModel.sex.onNext(user.sex)
    }
}
