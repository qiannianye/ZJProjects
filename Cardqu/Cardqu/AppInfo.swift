//
//  AppInfo.swift
//  Cardqu
//
//  Created by qiannianye on 2017/12/4.
//  Copyright © 2017年 qiannianye. All rights reserved.
//

import Foundation

struct AppInfo {
    //获取app名称
    static let appDisplayName: String = Bundle.main.infoDictionary?["CFBundleDisplayName"] as! String
    
    //获取build版本号
    static let buildVersion: String = Bundle.main.infoDictionary?["CFBundleVersion"] as! String
    
    //获取app版本号
    static let appVersion: String = Bundle.main.infoDictionary?["CFBundleShortVersion"] as! String
    
    //获取bundle identifier
    static let bundleId: String = Bundle.main.infoDictionary?["CFBundleIdentifier"] as! String
}
