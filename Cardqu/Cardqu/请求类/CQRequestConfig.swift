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
    var parameterEncoding: ParameterEncoding
    var isNeedToken: Bool = false
    
    init(url: String, method: HTTPMethod = .get, headers: [String: String]? = nil, parameters: [String: Any], respondsType: RespondsDataType, paraEncoding: ParameterEncoding = URLEncoding.default) {
        self.requestUrl = url
        self.method = method
        self.headers = headers
        self.respondsType = respondsType
        self.parameterEncoding = paraEncoding
        self.publicParameters()
        self.generateParameters(paraDic: parameters)
    }
    
    private func publicParameters() {
        parameters["os"] = "iOS"
        parameters["project"] = "kaqu"
        parameters["version"] = AppInfo.appVersion
    }
    
    private func generateParameters(paraDic: [String: Any]){
        for (key,value) in paraDic {
            parameters[key] = value
        }
    }
}
