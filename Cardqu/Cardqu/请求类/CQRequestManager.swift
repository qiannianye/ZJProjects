//
//  CQRequestManager.swift
//  Cardqu
//
//  Created by qiannianye on 2018/1/11.
//  Copyright © 2018年 qiannianye. All rights reserved.
//

import Foundation
import Alamofire

typealias RequestSuccessBlock = (AnyObject) -> Void
typealias RequestFailBlock = (APIError) -> Void

final class HttpRequestManager{
    //MARK:单例
    static let shared = HttpRequestManager()
    private var currentService = CQServiceEnvironment.test
    
    //请求manager
    lazy var manager: SessionManager = {
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 60
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
    func baseRequestWithConfig(config: HttpRequestConfiguration, success: @escaping RequestSuccessBlock, fail: @escaping RequestFailBlock) -> Void {
        
        var url = config.requestUrl
        if url.hasPrefix("http://") || url.hasPrefix("https://") {
            
        }else{
            url = currentService.host + url
        }
        
//        guard url.hasPrefix("http://") || url.hasPrefix("https://") else { return }
//        url = currentService.host + url
        
        var headerDic: HTTPHeaders?
        if config.isNeedToken {
            if let token = UserManager.default.user?.access_token {
                headerDic = ["Authorization":("Bearer " + token)]
            }
        }

        manager.request(url, method: config.method, parameters: config.parameters, encoding: URLEncoding.default, headers: headerDic).responseData { [unowned self] (responds) in
            self.handleRespondsData(respondsData: responds, success: success, fail: fail)
        }
    }
    
    
    //MARK:数据处理
    func handleRespondsData(respondsData: DataResponse<Data>, success: RequestSuccessBlock, fail: RequestFailBlock) {
        guard respondsData.result.error == nil else { //请求成功后,result.error返回的是nil
            //处理失败的结果
            //let error = APIError((respondsData.response?.statusCode)!)
            fail(APIError(-1))
            return
        }
        //成功的结果
        let respondsDic = dataConvertDictionary(data: respondsData.result.value!)
        
        //有的请求没有err_msg或者err_code,因为这两个字段是自己的服务器返回的,但是如果是请求微信或者其他第三方时,返回的是第三方的数据,那么此时会崩溃.因为字典里取该字段,该字段没有时,取不到值,nil直接解包String,导致崩溃.
        
        //这样写易导致崩溃
//        let resultMsg = respondsDic["err_msg"] as! String
//        let resultCode = respondsDic["err_code"] as! NSNumber
        
        if let resultMsg = respondsDic["err_msg"] {
            //展示message
            print("err_msg:[\(resultMsg)]")
        }
        
        if let resultCode = respondsDic["err_code"] {
            let code = resultCode as! NSNumber
            if code.intValue == 0 {//请求数据成功
                success(respondsDic as AnyObject)
            }else{
//                let error: Error! = "请求成功,返回数据失败,code不为0" as! Error
//
//                fail(error)
            }
        }else{
            success(respondsDic as AnyObject)
        }
        print("respondsData:\(respondsDic)")
    }
    
    func dataConvertDictionary(data: Data) -> Dictionary<String,Any> {
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            let dic = json as! Dictionary<String,Any>
            return dic
        } catch _ {
            return Dictionary<String,Any>()
        }
    }
}


