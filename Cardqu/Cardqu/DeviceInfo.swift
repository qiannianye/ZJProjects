//
//  DeviceInfo.swift
//  Cardqu
//
//  Created by qiannianye on 2017/12/4.
//  Copyright © 2017年 qiannianye. All rights reserved.
//

import Foundation

let screenWidth = UIScreen.main.bounds.size.width
let screenHeight = UIScreen.main.bounds.size.height
let statusBarH = UIApplication.shared.statusBarFrame.height
let naviBarH: CGFloat = (statusBarH + 44) //加上状态栏的高度
let tabBarH: CGFloat = ((statusBarH > 20) ? 83 : 49)
let isIphoneX = ((statusBarH > 20) ? true : false)



struct DeviceInfo {
    //机名,例如"Xiao's iPhone"
    static let name = UIDevice.current.name
    
    //手机系统版本,例如9.0
    static let systemVersion = UIDevice.current.systemVersion
    
    //手机系统名称,例如"iOS"
    static let systemName = UIDevice.current.systemName
    
    //机型,例如"iPhone" ,"iPod touch"
    static let model = UIDevice.current.model
    
    //uuid
    static let uuid = UIDevice.current.identifierForVendor?.uuid
}


