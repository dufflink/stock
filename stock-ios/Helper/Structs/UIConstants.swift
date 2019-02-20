//
//  Constants.swift
//  stock-ios
//
//  Created by Maxim Skorynin on 06/02/2019.
//  Copyright © 2019 Maxim Skorynin. All rights reserved.
//

import Foundation
import UIKit

struct VCIdentifier {
    static let startVC = "StartViewController"
    static let tabBarNavVC = "TabsNavigationController"
    static let mainNavVC = "MainNavigationController"
    static let updateUserProfileVC = "UpdateUserProfileViewController"
    
}

struct Storyboards {
    static let main = UIStoryboard(name: "Main", bundle: Bundle.main)
    static let user = UIStoryboard(name: "User", bundle: Bundle.main)
    static let categories = UIStoryboard(name: "Categories", bundle: Bundle.main)
    static let news = UIStoryboard(name: "News", bundle: Bundle.main)
}
