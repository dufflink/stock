//
//  UserProfileViewController.swift
//  stock-ios
//
//  Created by Maxim Skorynin on 12/02/2019.
//  Copyright © 2019 Maxim Skorynin. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class UserProfileViewController : AppViewController {
    
    @IBOutlet weak var amountSaved: UILabel!
    @IBOutlet weak var bonusCount: UILabel!
    @IBOutlet weak var subscribe: StyleButton!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var more: UIBarButtonItem!
    
    let userProfileViewModel = UserProfileViewModel()
    let disposeBag = DisposeBag()
    
    let cellIdentifier = "AttendedCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUserInfo()
        bindingViewModel()
        userProfileViewModel.userInfoViewModel.getUserInfo()
        userProfileViewModel.getUserStat()
    }
    
    func bindingViewModel() {
        tableView.dataSource = nil
        tableView.delegate = nil
        tableView.register(UINib(nibName: "AttendedCompanyView", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        
        userProfileViewModel.attendedStats.bind(to: tableView.rx.items(cellIdentifier: cellIdentifier,
            cellType: AttendedCompanyTableViewCell.self)) { (row, element, cell) in
                print("set table")
                cell.configure(data: element)
            
        }.disposed(by: disposeBag)
        
        more.rx.tap
            .subscribe(onNext: { [unowned self] in
                self.showMoreMenu()
            }).disposed(by: disposeBag)
    }
    
    func setCallBack() {
        userProfileViewModel.userInfoViewModel.result.asObserver()
            .subscribeOn(SerialDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
            .skip(1)
            .bind { value in
                switch value {
                case .isSuccess:
                    print("Set user info")
                    self.setUserInfo()
                case .errorDecode, .errorRequst, .errorEncode, .isFailure(_):
                    break
                case .noInternetConnection:
                    self.showAlertNoConnection()
                }
            }.disposed(by: disposeBag)
    }
    
    override func setLayoutOptions() {
        view.backgroundColor = UIColor.AppColor.Red.redUltraWhite
        navigationController?.navigationBar.barStyle = .black
        title = "Профиль"
    }
    
    func setUserInfo() {
        let user = User.shared
        amountSaved.text = String(format: "%.2f", user.amountSave)
        bonusCount.text = String(user.bonus)
    }
    
    func showMoreMenu() {
        let alert = UIAlertController(title: "Меню", message: nil, preferredStyle: .alert)
        let updateProfile = UIAlertAction(title: "Редактировать профиль", style: .default, handler: { _ in
            //TODO: Обновление профиля
        })
        let exit = UIAlertAction(title: "Выход", style: .default, handler: { _ in
            self.showExitMenu()
        })
        alert.addAction(updateProfile)

        alert.addAction(exit)
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func showExitMenu() {
        let logOutMenu = UIAlertController(title: "Вы вошли как \(String(User.shared.login!))", message: nil, preferredStyle: .actionSheet)
        
        let cancel = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        let logOut = UIAlertAction(title: "Выйти", style: .destructive, handler: { (alert: UIAlertAction!) -> Void in
            User.shared.setDefaultSetting()
            self.setRootController(storyboard: Storyboards.main, vcId: VCIdentifier.mainNavVC)
        
        })
        
        logOutMenu.addAction(cancel)
        logOutMenu.addAction(logOut)
        
        self.present(logOutMenu, animated: true, completion: nil)
    }
}
