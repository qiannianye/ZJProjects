//
//  UIViewController+Extension.swift
//  Cardqu
//
//  Created by qiannianye on 2018/3/9.
//  Copyright © 2018年 qiannianye. All rights reserved.
//

import Foundation

extension UIViewController{
    static func slidingPushNaviVC() -> UINavigationController{
        let window = UIApplication.shared.keyWindow
        let rootVC = window?.rootViewController as! SlidingMenuVC
        rootVC.closeLeftMenu(offsetX: screenWidth)
        
        guard let naviVC = rootVC.mainVC?.childViewControllers[0] else { return UINavigationController() }
        return naviVC as! UINavigationController
    }
}
