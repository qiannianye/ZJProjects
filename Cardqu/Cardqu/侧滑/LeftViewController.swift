//
//  LeftViewController.swift
//  Cardqu
//
//  Created by qiannianye on 2017/11/7.
//  Copyright © 2017年 qiannianye. All rights reserved.
//

import UIKit
import ReactiveSwift
import Result

class LeftViewController: UIViewController {
    
    let header: UIView = {
        let header = MineHeader.loadNibView()
        header.frame = CGRect(x: 0, y: statusBarH, width: screenWidth, height: 150)
        return header
    }()

    private var viewModel: MineHeaderViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        notifi()
        
        viewModel = MineHeaderViewModel()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

extension LeftViewController {
    func setupUI() {
       self.view.backgroundColor = UIColor.white
        view.addSubview(header)
    }
    
    func notifi() {
        NotificationCenter.default.addObserver(self, selector: #selector(loadUserInfo), name: NSNotification.Name(rawValue: "LoginSuccess"), object: nil)
    }
    
    @objc private func loadUserInfo(){
        let infoProducer = UserAPI().userVipInfo(needInfo: "0")
        infoProducer.startWithValues { [unowned self] (value) in
            
            let model = VipInfoModel.deserialize(from: value as? Dictionary)
            self.viewModel?.model = model
            self.viewModel?.header = self.header as? MineHeader
        }
    }
}
