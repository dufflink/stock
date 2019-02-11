//
//  Api.swift
//  stock-ios
//
//  Created by Maxim Skorynin on 06/02/2019.
//  Copyright © 2019 Maxim Skorynin. All rights reserved.
//
//MARK: For tests
//  let convertedString = String(data: jsonData, encoding: .utf8)
//  print(convertedString!)

import Foundation
import Alamofire
import SwiftyJSON

enum ResultApiCall {
    case errorEncode, errorDecode, errorRequst, isSuccess, isFailure(code : Int)
}

class Api {
    
    static let shared = Api()
    
        func signUp(info : SignUpData, completionHandler: @escaping (ResultApiCall) -> ()) {
            var jsonData : Data!
            do {
                jsonData = try JSONEncoder().encode(info)
            } catch {
                completionHandler(.errorEncode)
                return
            }
            var request = URLRequest(url: URL(string: Urls.signup)!)
            request.httpMethod = HTTPMethod.post.rawValue
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
            
            Alamofire.request(request).responseJSON { response in
                let code = response.response?.statusCode
                if code == 200 {
                    do {
                        let json = try JSON(data: response.data!) as JSON?
                        guard let code = json!["code"].int else {
                            completionHandler(.errorDecode)
                            return
                        }
                        if code == 0 {
                            completionHandler(.isSuccess)
                        } else {
                            completionHandler(.isFailure(code : code))
                        }
                        
                    } catch let error {
                        print("Error decode json: ", error)
                    }
                } else {
                    print("Error send request:", response.result.error!)
                    completionHandler(.errorRequst)
                }
            }
    }
}
