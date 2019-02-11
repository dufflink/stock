//
//  UIViewController.swift
//  stock-ios
//
//  Created by Maxim Skorynin on 11/02/2019.
//  Copyright © 2019 Maxim Skorynin. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD

extension UIViewController {
    
    func showAlertOk(title : String, message : String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "ОК", style: .default, handler: nil)
        
        alert.addAction(ok)
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func showAlertOkWithAction(title : String, message : String, action:@escaping () -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "ОК", style: .default, handler: { _ in
            action()
        })
        
        alert.addAction(ok)
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func showHud() {
        DispatchQueue.main.async {
            let _ = MBProgressHUD.showAdded(to: self.view, animated: true)
        }
    }
    
    func hideHud() {
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }
    
    func showSuccesHud() {
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.mode = .customView
        hud.label.text = "Успешно"
        
        hud.customView = UIImageView(image: #imageLiteral(resourceName: "CheckMark"))
        hud.hide(animated: true, afterDelay: 2)
    }
}
