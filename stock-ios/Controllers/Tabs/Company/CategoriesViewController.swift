//
//  CategoriesViewController.swift
//  stock-ios
//
//  Created by Maxim Skorynin on 12/02/2019.
//  Copyright © 2019 Maxim Skorynin. All rights reserved.
//

import Foundation
import UIKit

class CategoriesViewController : AppViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setLayoutOptions() {
        navigationController?.navigationBar.barStyle = .black
        view.backgroundColor = UIColor.AppColor.Red.redUltraWhite
        title = "Категории"

    }
}
