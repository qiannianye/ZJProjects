//
//  CQRequestManager.swift
//  Cardqu
//
//  Created by qiannianye on 2018/1/11.
//  Copyright © 2018年 qiannianye. All rights reserved.
//

import Foundation
import Alamofire

//typealias RequestSuccessBlock = (AnyObject) ->Void
//typealias RequestFailBlock = (Error) ->Void

final class HttpRequestManager{
    //MARK:单例
    static let shared = HttpRequestManager()
    private var currentService = CQServiceEnvironment.test
    
    //请求manager
    lazy var manager: SessionManager = {
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 10
        sessionConfig.timeoutIntervalForResource = 20
        let sessionDelegate = SessionDelegate()
        sessionDelegate.sessionDidReceiveChallenge = {(session: URLSession, challege: URLAuthenticationChallenge) in
            return (URLSession.AuthChallengeDisposition.useCredential,URLCredential(trust: challege.protectionSpace.serverTrust!))
        }
        return SessionManager.init(configuration: sessionConfig, delegate: sessionDelegate, serverTrustPolicyManager: nil)
        //问题:Editor placeholder in source file
        //原因:类型不匹配.调整修改参数类型.
    }()
}

extension HttpRequestManager {
    func baseRequestWithConfig(config: HttpRequestConfiguration, success: RequestSuccessBlock, fail: RequestFailBlock) -> Void {
        
        var url = config.requestUrl
        //        if url.hasPrefix("http://") || url.hasPrefix("https://") {
        //
        //        }else{
        //            url = currentService.host + url
        //        }
        
        guard url.hasPrefix("http://") || url.hasPrefix("https://") else { return }
        url = currentService.host + url
        
        manager.request(url, method: config.method, parameters: config.parameters, encoding: config.parameterEncoding, headers: config.headers).responseData { (responds) in
            //
        }
    }
    
    
    //MARK:数据处理
    func handleRespondsData(requestApi: HttpRequestAPI, respondsData: DataResponse<Any>, success: RequestSuccessBlock, fail: RequestFailBlock) {
        guard respondsData.result.error == nil else { //请求成功后,result.error返回的是nil
            //处理失败的结果
            fail(respondsData.result.error!)
            return
        }
        //成功的结果
        let respondsDic = respondsData.result.value as! Dictionary<String, Any>
        let resultMsg = respondsDic["msg"] as! String
        let resultCode = respondsDic["code"] as! String
        if resultCode.isEqualTo("0") {//请求数据成功
            success(respondsDic as AnyObject)
        }
        
        if resultMsg.lengthOfBytes(using: String.Encoding.utf8) > 0 {
            //展示message
        }
    }
}


