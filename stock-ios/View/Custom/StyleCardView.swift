//
//  StyleCardView.swift
//  stock-ios
//
//  Created by Maxim Skorynin on 11/02/2019.
//  Copyright © 2019 Maxim Skorynin. All rights reserved.
//

import Foundation
import UIKit

class StyleCardView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    func setupView() {
        backgroundColor = UIColor.white.withAlphaComponent(0.95)
        layer.cornerRadius = 8
    }
}
