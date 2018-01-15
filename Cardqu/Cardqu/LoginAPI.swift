//
//  LoginAPI.swift
//  Cardqu
//
//  Created by qiannianye on 2018/1/11.
//  Copyright © 2018年 qiannianye. All rights reserved.
//

import UIKit
import Alamofire
import ReactiveSwift
import Result

class LoginAPI: HttpAPIManager {
    
    func mobileLogin(userName: String, password: String, type: String, clientId: String, appId: String) -> SignalProducer<Any?, NoError> {
        let dic = ["username":userName, "password": password, "type":type, "client_id":clientId, "ky_app_id":appId]
        let confi = HttpRequestConfiguration(url: "/2.3/user/login.json", method: .post, headers: nil, parameters: dic, respondsType: .json, paraEncoding: URLEncoding.default)
        return producer(confi: confi)
    }
}
