//
//  UIImageView.swift
//  stock-ios
//
//  Created by Maxim Skorynin on 18/02/2019.
//  Copyright © 2019 Maxim Skorynin. All rights reserved.
//

import Foundation
import Kingfisher

extension UIImageView {
    func loadPicture(url: String) {
        if !url.isEmpty {
            self.kf.setImage(with: URL(string: url), placeholder: nil, options: [.transition(ImageTransition.fade(0.5))], progressBlock: nil, completionHandler: nil)
        }
    }
}
