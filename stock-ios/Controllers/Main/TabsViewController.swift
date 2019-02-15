//
//  TabsViewController.swift
//  stock-ios
//
//  Created by Maxim Skorynin on 06/02/2019.
//  Copyright © 2019 Maxim Skorynin. All rights reserved.
//

import Foundation
import UIKit

class TabsViewController: UITabBarController {
    
    override func viewDidLoad() {
        setTabs()
        setLayoutOptions()
    }
    
    func setTabs() {
        let user = Storyboards.user.instantiateInitialViewController()
        let categories = Storyboards.categories.instantiateInitialViewController()
        let news = Storyboards.news.instantiateInitialViewController()
        
        let controllers = [news, categories, user]
        
        self.viewControllers = controllers.map {
            UINavigationController(rootViewController: $0 as! AppViewController)
        }
    }
    
    func setLayoutOptions() {
//        self.tabBar.barStyle = .black
//        self.tabBar.tintColor = UIColor.AppColor.Red.redLight
    }
}
