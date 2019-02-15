//
//  CompanyData.swift
//  stock-ios
//
//  Created by Maxim Skorynin on 15/02/2019.
//  Copyright © 2019 Maxim Skorynin. All rights reserved.
//

import Foundation

class CompanyData {
    var id : Int64!
    var title : String!
    var description : String!
    var percent : Int!
    var workingHours : String!
    var links : [String]!
    var address : String!
    var phone : String!
    var pictureUrl : String!
    var email : String!
    var rating : Float!
    
    init() {}
    
    init(id : Int64, title : String, description : String,
         percent : Int, workingHours : String, links : [String],
         address : String, phone : String, pictureUrl : String,
         email : String, rating : Float) {
        
    }

    init(id : Int64, title : String) {
        self.id = id
        self.title = title
    }
}

class GetCompanyByIdData : Codable {
    var params : IdParams!
    var method = Methods.getUserStat
}
