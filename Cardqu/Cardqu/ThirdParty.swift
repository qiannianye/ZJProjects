//
//  ThirdParty.swift
//  Cardqu
//
//  Created by qiannianye on 2018/1/19.
//  Copyright © 2018年 qiannianye. All rights reserved.
//

import Foundation

//enum <#name#> {
//    case <#case#>
//}

class ThirdShare: NSObject {
    static let share = ThirdShare()
    let delegate = UIApplication.shared.delegate as! AppDelegate
    
    
    func wxAuthorization(controller: UIViewController) {
        let req = SendAuthReq()
        req.state = "ka__qu321"
        req.scope = "snsapi_message,snsapi_userinfo,snsapi_friend,snsapi_contact" //post_timeline,sns
        WXApi.sendAuthReq(req, viewController: controller, delegate:delegate)
    }
    
    func wxResp(resp: SendAuthResp){
        UserAPI().wxAuth(code: resp.code)
    }
}

extension ThirdShare: WXApiDelegate{

    func onResp(_ resp: BaseResp!) {
        if resp.isKind(of: PayResp.self) {//调起支付返回的处理
            
        }else if resp.isKind(of: SendMessageToWXResp.self){//向微信端发送信息后返回的处理
            
        }else if resp.isKind(of: SendAuthResp.self){//向微信端申请认证或者权限后返回处理
            let authResp: SendAuthResp = resp as! SendAuthResp
            UserAPI().wxAuth(code: authResp.code)
            
            
        }else{//其他:比如打开网页,打开微信指定页面
            
        }
    }
}

