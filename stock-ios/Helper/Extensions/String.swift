//
//  String.swift
//  stock-ios
//
//  Created by Maxim Skorynin on 09/02/2019.
//  Copyright © 2019 Maxim Skorynin. All rights reserved.
//

import Foundation

extension String {
    func matches(_ regex: String) -> Bool {
        return self.range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
    }
}
