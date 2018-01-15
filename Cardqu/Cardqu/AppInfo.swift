//
//  AppInfo.swift
//  Cardqu
//
//  Created by qiannianye on 2017/12/4.
//  Copyright © 2017年 qiannianye. All rights reserved.
//

import Foundation

let infoDic = Bundle.main.infoDictionary

struct AppInfo {
    //获取app名称
    static var appDisplayName: String {
        if let displayName = infoDic!["CFBundleDisplayName"]{
            return displayName as! String
        }
        return ""
    }
    
    //获取build版本号
    static var buildVersion: String {
        if let bversion = infoDic!["CFBundleVersion"] {
            return bversion as! String
        }
        return ""
    }
    
    //获取app版本号
    static var appVersion: String {
        if let aversion = infoDic!["CFBundleShortVersionString"] {
            return aversion as! String
        }
        return ""
    }
    
    //获取bundle identifier
    static var bundleId: String {
        if let bdId = infoDic!["CFBundleIdentifier"] {
            return bdId as! String
        }
        return ""
    }
    
    
    //下面这种写法,如果字典里取值时,key值如果写错了,取出来为nil,解包时会崩溃
    //static let appDisplayName: String = Bundle.main.infoDictionary?["CFBundleDisplayName"] as! String //获取app名称
    
    //static let buildVersion: String = Bundle.main.infoDictionary?["CFBundleVersion"] as! String //获取build版本号
    
    //static let appVersion: String = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String //获取app版本号
    
    //static let bundleId: String = Bundle.main.infoDictionary?["CFBundleIdentifier"] as! String //获取bundle identifier
}
