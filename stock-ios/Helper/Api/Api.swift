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
            guard let request = makeRequest(info: info, url: Urls.signup) else {
                completionHandler(.errorEncode)
                return
            }
            
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
    
    func signIn(info : SignInData, completionHandler: @escaping (ResultApiCall) -> ()) {
        guard let request = makeRequest(info: info, url: Urls.signin) else {
            completionHandler(.errorEncode)
            return
        }
        
        Alamofire.request(request).responseJSON { response in
            let code = response.response?.statusCode
            if code == 200 {
                do {
                    let json = try JSON(data: response.data!) as JSON?
                    guard let code = json!["code"].int else {
                        completionHandler(.errorDecode)
                        return
                    }
                    switch code {
                    case 0:
                        guard let status = json!["status"].stringValue as String? else {
                            completionHandler(.errorDecode)
                            return
                        }
                        if status.elementsEqual("user login success") {
                            let token = json!["value"]["token"].stringValue
                            print("Token is \(token)")
                            User.shared.token = token
                            completionHandler(.isSuccess)
                        } else {
                            completionHandler(.isFailure(code: 999))
                        }
                    case 4: completionHandler(.isFailure(code: 777))
                    case 6: completionHandler(.isFailure(code: 888))
                    case 8: completionHandler(.isFailure(code: 444))
                    default: break
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
    
    func checkToken(info : CheckTokenData, completionHandler: @escaping (ResultApiCall) -> ()) {
        guard let request = makeRequest(info: info, url: Urls.checktoken) else {
            completionHandler(.errorEncode)
            return
        }
        
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
                        let id = Int64(json!["value"]["id"].stringValue)
                        User.shared.id = id
                        completionHandler(.isSuccess)
                    } else {
                        completionHandler(.isFailure(code: 0))
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
    
    func getUserInfo(info : GetUserInfoData, completionHandler: @escaping (ResultApiCall) -> ()) {
        guard let request = makeRequest(info: info, url: Urls.getUserInfo) else {
            completionHandler(.errorEncode)
            return
        }
        
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
                        guard let userObject = json!["value"]["user"] as JSON? else {
                            completionHandler(.errorDecode)
                            return
                        }
                        
                        User.shared.setUser(userObject)
                        completionHandler(.isSuccess)
                    } else {
                        completionHandler(.isFailure(code: 0))
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
    
    func getUserStat(info : GetUserStatData, completionHandler: @escaping (ResultApiCall) -> ()) {
        guard let request = makeRequest(info: info, url: Urls.getUserStat) else {
            completionHandler(.errorEncode)
            return
        }
        
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
                        guard let companyStatistics = json!["value"]["companyStatistic"].arrayValue as [JSON]? else {
                            completionHandler(.errorDecode)
                            return
                        }
                        
                        User.shared.setCompanyStatictics(companyStatistics)
                        
                        completionHandler(.isSuccess)
                    } else {
                        completionHandler(.isFailure(code: 0))
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
