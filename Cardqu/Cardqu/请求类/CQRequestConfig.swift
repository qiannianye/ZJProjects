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
    var headers: [String: String]?
    var parameters = Dictionary<String, Any>()
    var respondsType = RespondsDataType.json
    var parameterEncoding: ParameterEncoding = URLEncoding.default
    var isNeedToken: Bool = false
    
    //不签名
    init(url: String, method: HTTPMethod = .get, headers: [String: String]? = nil, parameters: [String: Any], respondsType: RespondsDataType, paraEncoding: ParameterEncoding = URLEncoding.default) {
        self.requestUrl = url
        self.method = method
        self.headers = headers
        self.respondsType = respondsType
        self.parameterEncoding = paraEncoding
        self.publicParameters() //第三方请求时不需要公共参数,做处理
        self.generateParameters(paraDic: parameters)
    }
    
    //签名
    init(url: String, method: HTTPMethod = .post, headers: [String: String]? = nil, parametersStr: String) {
        self.requestUrl = url
        self.method = method
        self.headers = headers
        self.siginParameters(paraStr: parametersStr)
    }
    
    //签名
    private func siginParameters(paraStr: String) /*-> Dictionary<String,Any>*/{
        publicParameters()
        let timestamp = String.init(format: "%.f", Date().timeIntervalSince1970)
        parameters["timestamp"] = timestamp
        parameters["appsecret"] = "4iT0UCL0BQTS7XN9YC04B2YkV2F4K3"
        
        let arr = paraStr.components(separatedBy: "&")
//        var paraKeyArr = [String]()
//        var paraValueArr = [String]()
        for item in arr {
            let tmpArr = item.components(separatedBy: "=")
//            paraKeyArr.append(tmpArr.first!)
//            paraValueArr.append(tmpArr.last!)
            parameters[tmpArr.first!] = tmpArr.last!
        }
        
//        let parametersName = parameters.keys
//        let sortedParameters = parametersName.sorted()
//        print("sorted parameters:[\(sortedParameters)]")
        let sort =  parameters.sorted { (arg0, arg1) -> Bool in
            let (_, _) = arg1
            let (_, _) = arg0
            return arg0.key < arg1.key
        }//返回元素是元组的数组
        print("sorted -[\(sort)]")
        
        var str = ""
        for item in sort {
            str.append(item.value as! String)
        }
        print("str---[\(str)]")
        let md5Str = str.md5String()
        print("md5--[\(md5Str)]")
        
        
    }
    
    //公共参数
    private func publicParameters() {
        //parameters["os"] = "iOS"
        parameters["project"] = "kaqu"
        parameters["version"] = AppInfo.appVersion
    }
    
    private func generateParameters(paraDic: [String: Any]){
        for (key,value) in paraDic {
            parameters[key] = value
        }
    }
}
