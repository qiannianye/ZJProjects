//
//  HttpRequestDTO.swift
//  Cardqu
//
//  Created by qiannianye on 2017/12/4.
//  Copyright © 2017年 qiannianye. All rights reserved.
//

import UIKit

enum PTRequestMethod: String{
    case Get = "0"
    case Post = "1"
    case Upload = "2"
    case Download = "3"
}

class HttpRequestDTO: NSObject {
    var parameters = Dictionary<String , Any>.init() //参数(字典类型)
    var requestMethod: PTRequestMethod = PTRequestMethod.Post //默认post请求
    var urlStr = "" //请求的url
    var successCode = 0
    var isNeedToken = false //默认false
    
    override init() {
        super.init()
        publicParameters()
    }
    
    //MARK:参数
    //公共参数
    func publicParameters() {
        parameters["os"] = "iOS"
        parameters["project"] = "kaqu"
        parameters["version"] = AppInfo.appVersion
        
        if isNeedToken {
            //获取token并设置为参数
        }
    }
    
    //生成参数
    func generaParameters(dic: Dictionary<String, Any>) {
        for (key,value) in dic {
            parameters[key] = value
        }
    }
    
    //MARK:返回数据. 父类只提供接口,需要子类重写该方法.
    func getRespondsData(respondsData: AnyObject, error: Error?) -> AnyObject {
        return "" as AnyObject
    }
}

