//
//  CompanyStatistic.swift
//  stock-ios
//
//  Created by Maxim Skorynin on 12/02/2019.
//  Copyright © 2019 Maxim Skorynin. All rights reserved.
//

import Foundation

class CompanyStatistic {
    var id : Int64!
    var entryCount : Int!
    var amountSave : Float!
    var isRated : Int!
    
    init(id : Int64, entryCount : Int, amountSave : Float, isRated : Int!) {
        self.id = id
        self.entryCount = entryCount
        self.amountSave = amountSave
        self.isRated = isRated
    }
}
