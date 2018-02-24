//
//  UserManager.swift
//  Cardqu
//
//  Created by qiannianye on 2018/1/31.
//  Copyright © 2018年 qiannianye. All rights reserved.
//

import Foundation

let uuid = UUIDManager.readUUID()
let accountFileName = "account.plist"
let usernameKey = "username"
let passwordKey = "password"

//游客
struct CQVisitor {
    static var name: String{
        return "vuser.ios.\(uuid)"
    }
    
    static var password: String{
        if uuid.count >= 6 {
            let pwdRang = (uuid.count - 6)..<uuid.count
            return uuid.substringFrom(pwdRang.lowerBound)
        }
        return "UUIDError"
    }
}

//用户
struct CQUser {
    static var name: String = ""
    static var password: String = ""
    static func saveAccount() {
        let userFile = String.filePath(fileName: accountFileName)
        let userDic = NSMutableDictionary()
        userDic[usernameKey] = CQUser.name
        userDic[passwordKey] = CQUser.password
        userDic.write(toFile: userFile, atomically: true)
    }
}



class UserManager {
    static let `default` = {
        return UserManager()
    }()

    var user: UserModel?
    
    var isLogin: Bool {
        if user == nil {
            return false
        }
        return true
    }
    
    var isVisitor: Bool {
        
        if user == nil {
            return true
        }else{
            guard let name = user?.name else { return true }
            if name.isEqualTo(CQVisitor.name) { return true }
            return false
        }
    }
    
    
    init() {
        
    }
    
    
}
