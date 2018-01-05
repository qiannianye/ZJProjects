//
//  LoginDTO.swift
//  Cardqu
//
//  Created by qiannianye on 2017/12/13.
//  Copyright © 2017年 qiannianye. All rights reserved.
//

import UIKit

enum LoginWay: Int {
    case MobileLogin = 0
    case ThirdpartyLogin = 1
}

class LoginDTO: HttpRequestDTO {
    
    override init() {
        super.init()
        self.urlStr = "/2.3/user/login.json"
        self.requestMethod = .Post
    }
    
    func mobileLoginParameters(userName: String, password: String, type: String, clientId: String, appId: String) {
        let dic = ["username":userName, "password": password, "type":type, "client_id":clientId, "ky_app_id":appId]
        generaParameters(dic: dic)
    }
    
    func setParameters(platform: String, accessToken: String, expiresin: String, clientId: String, openId: String, refreshToken: String, unionId: String) {
        let paraDic = ["platform":platform, "access_token":accessToken, "expires_in":expiresin, "client_id":clientId, "open_id":openId, "refresh_token":refreshToken, "union_id":unionId]
        generaParameters(dic: paraDic)
    }
    
    override func getRespondsData(respondsData: AnyObject, error: Error?) -> AnyObject {
        //super.getRespondsData(respondsData: respondsData, error: error)
        let r_data = UserModel.deserialize(from: (respondsData as! Dictionary))
        return r_data as AnyObject
    }
}
