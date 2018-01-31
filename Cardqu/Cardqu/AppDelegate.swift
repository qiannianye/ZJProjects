//
//  AppDelegate.swift
//  Cardqu
//
//  Created by qiannianye on 2017/11/6.
//  Copyright © 2017年 qiannianye. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,WXApiDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        //预先保存
        let uuid = UUIDManager.readUUID()
        if uuid.isEqualTo("") {
            UUIDManager.saveUUID(uuid:DeviceInfo.uuid!)
        }
        WXApi.registerApp(AppKey.wxAppID , enableMTA: false)
        
        
        
        let tabbarVC = BaseTabbarController()
        let leftVC = LeftViewController()
        let rootVC = SlidingMenuVC(mainVC: tabbarVC, leftVC: leftVC, gapWidth: screenWidth - 44)
        window?.rootViewController = rootVC
        
        LoginManager.share.login()
        
        
        
        //调试登录
//        let isLogin = UserDefaults.standard.value(forKey: "isLogin")
//        if isLogin != nil {
//            let tabbarVC = BaseTabbarController()
//            let leftVC = LeftViewController()
//            let rootVC = SlidingMenuVC(mainVC: tabbarVC, leftVC: leftVC, gapWidth: screenWidth - 44)
//            window?.rootViewController = rootVC
//        }else{
//            let loginVC = LoginViewController()
//            window?.rootViewController = loginVC
//        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


    //ios9,及之前
    func application(_ application: UIApplication, handleOpen url: URL) -> Bool {
        return WXApi.handleOpen(url, delegate: self)
    }
    
    //ios9之后
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        return WXApi.handleOpen(url, delegate: self)
    }
    
    //MARK: WXApiDelegate
    //向微信端发送信息
    func onReq(_ req: BaseReq!) {
        print("weixin onReq")
    }
    
    //接收微信端返回的信息
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

