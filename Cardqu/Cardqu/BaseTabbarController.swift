//
//  BaseTabbarController.swift
//  Cardqu
//
//  Created by qiannianye on 2017/11/6.
//  Copyright © 2017年 qiannianye. All rights reserved.
//

import UIKit

class BaseTabbarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let vcs = [["clsName":"HomeViewController","title":"首页","imgName":"tabbar_tuijian"],["clsName":"MallViewController","title":"商城","imgName":"tabbar_market"],["clsName":"","title":"","imgName":"tabbar_code_icon"],["clsName":"CouponBagVC","title":"券包","imgName":"tabbar_cardbag"],["clsName":"OrdersVC","title":"订单","imgName":"tabbar_jidian"],]
        var vcArr = [UIViewController]()
        for dic in vcs {
            let vc = self.getControllerFromDic(dic: dic)
            vcArr.append(vc)
        }
        self.viewControllers = vcArr;
    }

    
    private func getControllerFromDic(dic :[String : String])->UIViewController{
        guard let clsName = dic["clsName"],
            let title = dic["title"],
            let imgName = dic["imgName"],
            let cls = NSClassFromString(Bundle.main.namespace + "." + clsName) as? UIViewController.Type
            else{
               return UIViewController()
        }
        let vc = cls.init()
        vc.tabBarItem.title = title
        vc.tabBarItem.image = UIImage(named: imgName+"_normal")?.withRenderingMode(.alwaysOriginal)
        vc.tabBarItem.selectedImage = UIImage(named: imgName + "_selected")?.withRenderingMode(.alwaysOriginal)
        vc.tabBarItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor:UIColor.orange], for:.highlighted)
        let naviVC = BaseNavigationController.init(rootViewController: vc )
        return naviVC
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
