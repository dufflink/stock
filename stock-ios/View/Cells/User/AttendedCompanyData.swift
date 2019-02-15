//
//  AttendedCompanyData.swift
//  stock-ios
//
//  Created by Maxim Skorynin on 15/02/2019.
//  Copyright © 2019 Maxim Skorynin. All rights reserved.
//

import Foundation

class AttendedCompanyData {
    var companyId : Int64!
    var title : String!
    var count : String!
    var pictureUrl : String!
    var isRated : Int!
    
    init(companyId : Int64, title : String, count : String, pictureUrl : String, isRated : Int) {
        self.companyId = companyId
        self.title = title
        self.count = count
        self.pictureUrl = pictureUrl
        self.isRated = isRated
    }
}
