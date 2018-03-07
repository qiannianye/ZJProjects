//
//  BaseNavigationController.swift
//  Cardqu
//
//  Created by qiannianye on 2017/11/7.
//  Copyright © 2017年 qiannianye. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.barTintColor = UIColor.white
    
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor : UIColor.black, .font : UIFont.systemFont(ofSize: 14)], for: .normal)

        
//        UIBarButtonItem.setBackButtonBackgroundImage(UIBarButtonItem(image: UIImage(named: "back"), style: .plain, target: self, action: #selector()))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
