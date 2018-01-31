//
//  UserAPI.swift
//  Cardqu
//
//  Created by qiannianye on 2018/1/11.
//  Copyright © 2018年 qiannianye. All rights reserved.
//

import UIKit
import Alamofire
import ReactiveSwift
import Result

class UserAPI: HttpAPIManager {
    
    //手机登录
    func mobileLogin(userName: String, password: String, type: String, clientId: String, appId: String) -> SignalProducer<Any?, NoError> {
        
        //加密(pwd=123789):MWZmNmQ5YjAzMWVjMzVlZg==
        let encryptPwd = Base64DesFunc.encryptString(password, keyString: encryptKey)
        
        let paraStr = String.init(format: "username=%@&password=%@&type=%@&client_id=%@&ky_app_id=%@", userName, encryptPwd!, type, clientId, appId)
        let confi = HttpRequestConfiguration(url: "/2.3/user/login.json", method: .post, headers: nil, parametersStr: paraStr)
        return producer(confi: confi)
    }
    
    //第三方登录
    func thirdLogin(openId: String, unionId: String, platform: String, accessToken: String, clientId: String, expiresIn: String, appId: String) -> SignalProducer<Any?,NoError> {
        let dic = ["open_id":openId, "union_id":unionId, "platform": platform, "access_token":accessToken, "client_id":clientId, "expires_in":expiresIn, "ky_app_id":appId]
        let confi = HttpRequestConfiguration(url: "/2.3/auth/token.json", method: .post, headers: nil, parameters: dic, paraEncoding: URLEncoding.default)
        return producer(confi: confi)
    }
    
    //获取微信accesstoken
    func wxAuth(code: String){
        let wxAuthUrl = "https://api.weixin.qq.com/sns/oauth2/access_token?appid=\(AppKey.wxAppID)&secret=\(AppKey.wxAppSecret)&code=\(code)&grant_type=authorization_code"
        
        let confi = HttpRequestConfiguration(url: wxAuthUrl, method: .get, headers: nil, parameters: Dictionary<String,Any>(), paraEncoding: URLEncoding.default)
        
        self.startRequest(config: confi, success: { (resp) in
            print("微信授权:[\(resp)]")
            //授权成功后登录
            //待处理,返回数据赋值,等微博和qq一起处理
            let access_token = resp["access_token"] as! String
            let expires_in = resp["expires_in"] as! NSNumber
            let openid = resp["openid"] as! String
            //let refresh_token = resp["refresh_token"] as! String
            //let scope = resp["scope"] as! String
            let unionid = resp["unionid"] as! String
        
            let dic = ["open_id":openid, "union_id":unionid, "platform": "weixin", "access_token":access_token, "client_id":"IOS_" + AppInfo.appVersion, "expires_in":expires_in.stringValue, "ky_app_id":""]
            let confi = HttpRequestConfiguration(url: "/2.3/auth/token.json", method: .post, headers: nil, parameters: dic, paraEncoding: URLEncoding.default)
            self.startRequest(config: confi, success: { (resp) in
                //已成功,需要整理
                var rootVC = UIApplication.shared.keyWindow?.rootViewController
                if (rootVC?.isKind(of: LoginViewController.self))!{
                    rootVC = nil
                }
                
            }, fail: { (error) in
                //
            })
            
        }) { (error) in
            print("微信授权error:[\(error)]")
        }
    }
}
