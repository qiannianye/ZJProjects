//
//  LoginManager.swift
//  Cardqu
//
//  Created by qiannianye on 2018/1/30.
//  Copyright © 2018年 qiannianye. All rights reserved.
//

import Foundation
import ReactiveSwift

class LoginManager{
    static let share = LoginManager()
    
    func login() {
        let userPath = String.filePath(fileName: accountFileName)
        if FileManager.default.fileExists(atPath: userPath) {
            //存在,取数据
            let userDic = NSMutableDictionary(contentsOfFile: userPath)
            CQUser.password = userDic![usernameKey] as! String
            CQUser.name = userDic![passwordKey] as! String
            if CQUser.password.count > 0 {
                //用户登录
            }else{
                //游客
                CQUser.name = CQVisitor.name
                CQUser.password = CQVisitor.password
            }
        }else{
            //游客
            CQUser.name = CQVisitor.name
            CQUser.password = CQVisitor.password
        }
        
        loginAction(username: /*"13146992471" */ CQUser.name, password: /*"123789"*/ CQUser.password)
    }
    
    
    //login
    private func loginAction(username: String, password: String) {
        let loginSignalProducer = UserAPI().mobileLogin(userName: username, password: password, type: "general", clientId: "IOS_" + AppInfo.appVersion, appId: "")
        
        loginSignalProducer.startWithValues({ (value) in
            print("value is [\(String(describing: value))]")
            CQUser.saveAccount()
            UserManager.default.user = UserModel.deserialize(from: (value as! Dictionary))
            
            //发送通知
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "LoginSuccess"), object: nil, userInfo: nil)
        })
    }
}

