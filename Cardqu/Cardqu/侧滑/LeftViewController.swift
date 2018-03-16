//
//  LeftViewController.swift
//  Cardqu
//
//  Created by qiannianye on 2017/11/7.
//  Copyright © 2017年 qiannianye. All rights reserved.
//

import UIKit

class LeftViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension LeftViewController {
    private func setupUI(){
        let profileVC = ProfileViewController()
        view.addSubview(profileVC.view)
        addChildViewController(profileVC)
//        profileVC.view.snp.makeConstraints { (make) in
//            make.edges.equalTo(view)
//        }
    }
}
