//
//  PTRequestManager.swift
//  Cardqu
//
//  Created by qiannianye on 2017/12/11.
//  Copyright © 2017年 qiannianye. All rights reserved.
//

import UIKit
import Alamofire

typealias RequestSuccessBlock = (AnyObject) -> Void
typealias RequestFailBlock = (Error) -> Void

class PTRequestManager: NSObject{
    
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

    var baseUrl = "apijava.cardqu.t.KQService"
    static let shared = PTRequestManager()
    override init() {
        super.init()
    }
    
    //MARK:基本请求
    func baseRequestWithURL(requestApi: HttpRequestAPI, success: @escaping RequestSuccessBlock, fail: @escaping RequestFailBlock)  {
        //请求url
        let requestUrl = baseUrl + (requestApi.requestDTO?.urlStr)!
        
        //请求方式
        var method: HTTPMethod = HTTPMethod.get
        
        //问题:这里如果是requestApi.requestDTO?.requestMethod就会报错,需要是确定类型
        //原因解决:https://stackoverflow.com/questions/31085936/enum-case-is-not-a-member-of-type
        switch (requestApi.requestDTO?.requestMethod)! {
          case PTRequestMethod.Post:
            method = .post
          case PTRequestMethod.Download:
            method = .put
          case PTRequestMethod.Upload:
            method = .put
          default:
            break
        }
        //请求参数
        let paraDic = handleParameters(requestApi.requestDTO!.parameters)
        
        //开始请求
        manager.request(requestUrl, method: method, parameters: paraDic).responseJSON {
            responseData in
            DispatchQueue.main.async() {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
            //处理请求结果
            self.handleRespondsData(requestApi: requestApi, respondsData: responseData, success: success, fail: fail)
        }
    }
    
    //MARK:参数处理
    func handleParameters(_ paraDic: Dictionary<String,Any>) -> (Dictionary<String,String>) {
        var dic = Dictionary<String,String>()
        for (key,value) in paraDic {
            if value is NSData{
                
            }else if value is [AnyObject]{
                dic.updateValue(JsonStringAddition.convertArrayToString(arr: value as! [AnyObject]), forKey: key)
            }else if value is [String : AnyObject]{
                dic.updateValue(JsonStringAddition.converDicToString(dic: value as! [String : AnyObject]), forKey: key)
            }else{
                dic.updateValue(value as! String, forKey: key)
            }
        }
        return dic
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
