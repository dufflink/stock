//
//  ViewController.swift
//  stock-ios
//
//  Created by Maxim Skorynin on 05/02/2019.
//  Copyright © 2019 Maxim Skorynin. All rights reserved.
//

import UIKit

class LaunchScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.async {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return
            }
            appDelegate.window?.rootViewController = Storyboards.main.instantiateViewController(withIdentifier: VCIdentifier.mainNavVC)
            appDelegate.window?.makeKeyAndVisible()
        }
    }
}

