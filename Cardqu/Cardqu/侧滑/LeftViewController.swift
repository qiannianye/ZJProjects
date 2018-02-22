//
//  LeftViewController.swift
//  Cardqu
//
//  Created by qiannianye on 2017/11/7.
//  Copyright © 2017年 qiannianye. All rights reserved.
//

import UIKit

class LeftViewController: UIViewController {
    
    let header: UIView = {
        let header = MineHeader.loadNibView()
        header.frame = CGRect(x: 0, y: statusBarH, width: screenWidth, height: 150)
        return header
    }()
    
    
    private var viewModel: MineViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        notifi()
        var model = UserModel()
        model.display_name = "123k"
        model.icon_url = ""
        
        viewModel = MineViewModel()
        viewModel?.model = model
        viewModel?.header = header as? MineHeader
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

extension LeftViewController {
    func setupUI() {
       self.view.backgroundColor = UIColor.cyan
        view.addSubview(header)
    }
    
    func notifi() {
        NotificationCenter.default.addObserver(self, selector: #selector(loadUserInfo), name: NSNotification.Name(rawValue: "LoginSuccess"), object: nil)
    }
    
    @objc private func loadUserInfo(){
        UserAPI().userVipInfo(needInfo: "0")
    }
}
