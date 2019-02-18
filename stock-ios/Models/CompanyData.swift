//
//  CompanyData.swift
//  stock-ios
//
//  Created by Maxim Skorynin on 15/02/2019.
//  Copyright © 2019 Maxim Skorynin. All rights reserved.
//

import Foundation
import SwiftyJSON

class CompanyData {
    var id : Int64!
    var title : String!
    var description : String!
    var percent : Int!
    var workingHours : String!
    var links : [String]!
    var address : String!
    var phone : String!
    var pictureUrls : [String]! = []
    var email : String!
    var rating : Float!
    
    init() {}
    
    init(id : Int64, title : String, description : String,
         percent : Int, workingHours : [JSON], links : [JSON],
         address : String, phone : String, pictureUrl : String,
         email : String, rating : Float) {
        
        self.id = id
        self.title = title
        self.description = description
        self.percent = percent
        self.address = address
        self.phone = phone
        self.email = email
        
        for i in 0...links.count {
            self.links.append(links[i].stringValue)
        }
        
        separateUrls(pictureUrl: pictureUrl)
        
    }

    init(id : Int64, title : String, pictureUrl : String) {
        self.id = id
        self.title = title
        
        separateUrls(pictureUrl: pictureUrl)

    }
    
    func separateUrls(pictureUrl : String) {
        if !pictureUrl.isEmpty {
            let splitPictures = pictureUrl.split(separator: "|")
            for picture in splitPictures {
                self.pictureUrls.append(String(picture))
            }
        }
    }
}

class GetCompanyByIdData : Codable {
    var params : IdParams!
    var method = Methods.getCompanyById
}
