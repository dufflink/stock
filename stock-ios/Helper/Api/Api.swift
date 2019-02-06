//
//  Api.swift
//  stock-ios
//
//  Created by Maxim Skorynin on 06/02/2019.
//  Copyright © 2019 Maxim Skorynin. All rights reserved.
//

import Foundation
import Alamofire

class Api {
    
    static let shared = Api()
    
    func signUp(info : SignUpData, completionHandler: @escaping (String) -> ()) {
        do {
            let jsonData = try JSONEncoder().encode(info)
//            let convertedString = String(data: jsonData, encoding: .utf8)
//            print(convertedString!)
            var request = URLRequest(url: URL(string: Urls.signup)!)
            request.httpMethod = HTTPMethod.post.rawValue
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
            
            Alamofire.request(request).responseJSON { response in
                let code = response.response?.statusCode

                if code == 200 {
                    if response.result.isSuccess {
                        //TODO: handle response
                    } else {
                        //error
                        completionHandler("")
                    }
                } else {
                    print("Error send request:", response.result.error!)
                    completionHandler("")
                }
            }
        } catch {
            //error
            completionHandler("")
        }
    }
    
}
