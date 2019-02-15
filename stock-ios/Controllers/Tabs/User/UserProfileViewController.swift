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
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
}
