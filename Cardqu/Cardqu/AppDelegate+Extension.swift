//
//  AppDelegate+Extension.swift
//  Cardqu
//
//  Created by qiannianye on 2018/1/22.
//  Copyright © 2018年 qiannianye. All rights reserved.
//

import Foundation

//extension AppDelegate: WXApiDelegate{
//    //ios9,及之前
//    func application(_ application: UIApplication, handleOpen url: URL) -> Bool {
//        return WXApi.handleOpen(url, delegate: self)
//    }
//
//    //ios9之后
//    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
//        return WXApi.handleOpen(url, delegate: self)
//    }
//
//    //MARK: WXApiDelegate
//    //向微信端发送信息
//    func onReq(_ req: BaseReq!) {
//        print("weixin onReq")
//    }
//
//    //接收微信端返回的信息
//    func onResp(_ resp: BaseResp!) {
//
//        if resp.isKind(of: PayResp.self) {//调起支付返回的处理
//
//        }else if resp.isKind(of: SendMessageToWXResp.self){//向微信端发送信息后返回的处理
//
//        }else if resp.isKind(of: SendAuthResp.self){//向微信端申请认证或者权限后返回处理
//        let authResp: SendAuthResp = resp as! SendAuthResp
//        LoginAPI().wxAuth(code: authResp.code)
//
//
//        }else{//其他:比如打开网页,打开微信指定页面
//
//        }
//    }
//
//
//}

