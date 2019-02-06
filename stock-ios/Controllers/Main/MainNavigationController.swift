//
//  MainNavigationController.swift
//  stock-ios
//
//  Created by Maxim Skorynin on 06/02/2019.
//  Copyright © 2019 Maxim Skorynin. All rights reserved.
//

import Foundation
import UIKit

class MainNavigationController : UINavigationController {
    
    override func viewDidLoad() {
        guard let startVC = Storyboards.main.instantiateViewController(withIdentifier: VCIdentifier.startVC) as? StartViewController else {
            return
        }
        
        self.pushViewController(startVC, animated: true)
    }
    
}
