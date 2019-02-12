//
//  Api + Ext.swift
//  stock-ios
//
//  Created by Maxim Skorynin on 12/02/2019.
//  Copyright © 2019 Maxim Skorynin. All rights reserved.
//

import Foundation
import Alamofire

extension Api {
    func makeRequest<T : Codable>(info : T, url : String) -> URLRequest? {
        var jsonData : Data!
        do {
            jsonData = try JSONEncoder().encode(info)
        } catch {
            return nil
        }
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        return request
    }
}
