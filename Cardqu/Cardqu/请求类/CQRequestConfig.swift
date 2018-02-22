//
//  CQRequestConfig.swift
//  Cardqu
//
//  Created by qiannianye on 2018/1/11.
//  Copyright © 2018年 qiannianye. All rights reserved.
//

import Foundation
import Alamofire

enum RespondsDataType  {
    case data
    case json
    case string
}

class HttpRequestConfiguration {
    var requestUrl: String
    var method: HTTPMethod
    var parameters = Dictionary<String, Any>()
    var respondsType = RespondsDataType.json
    var isNeedToken: Bool = false
    
    //不签名的配置
    init(url: String, method: HTTPMethod = .get, parameters: [String: Any]?, isToken: Bool) {
        self.requestUrl = url
        self.method = method
        self.isNeedToken = isToken
        self.publicParameters() //第三方请求时不需要公共参数,做处理
        self.generateParameters(paraDic: parameters!)
    }
    
    //需要签名的配置
    init(url: String, method: HTTPMethod = .post, parametersStr: String, isToken: Bool) {
        self.requestUrl = url
        self.method = method
        self.isNeedToken = isToken
        self.siginParameters(paraStr: parametersStr)
    }
    
    //签名
    private func siginParameters(paraStr: String){
        publicParameters()
        
        let timestamp = String.init(format: "%.f", Date().timeIntervalSince1970)
        parameters["timestamp"] = timestamp
        parameters["appsecret"] = "4iT0UCL0BQTS7XN9YC04B2YkV2F4K3"
        
        let arr = paraStr.components(separatedBy: "&")
        for item in arr {
           let range = item.rangeOfCharacter(from: CharacterSet(charactersIn: "="))
            if range == nil {continue}
            let key = item.substringTo((range?.lowerBound.encodedOffset)!)
            let value = item.substringFrom((range?.upperBound.encodedOffset)!)
            parameters[key] = value
        }
        
        //排序,从小到大
        let sort =  parameters.sorted { (arg0, arg1) -> Bool in
            let (_, _) = arg1
            let (_, _) = arg0
            return arg0.key < arg1.key
        }//返回元素是元组的数组
        //print("sorted -[\(sort)]")
        
        var str = ""
        for item in sort {
            if item.key.isEqualTo("password") { continue }
            str.append(item.value as! String)
        }
        //print("str---[\(str)]")
        let md5Str = str.md5String()
        //print("md5--[\(md5Str)]")
        
        parameters["sign"] = md5Str
        parameters.removeValue(forKey: "appsecret")
    }
    
    //公共参数
    private func publicParameters() {
        parameters["project_type"] = "kaqu"
        parameters["login_version"] = String.init(format: "%@", AppInfo.appVersion)
        parameters["login_id"] = "201801261205388487903"
    }
    
    private func generateParameters(paraDic: [String: Any]){
        for (key,value) in paraDic {
            parameters[key] = value
        }
    }
}
