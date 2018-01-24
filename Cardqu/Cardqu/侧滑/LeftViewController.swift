//
//  LeftViewController.swift
//  Cardqu
//
//  Created by qiannianye on 2017/11/7.
//  Copyright © 2017年 qiannianye. All rights reserved.
//

import UIKit

class LeftViewController: UIViewController {
    
    let header = MineHeader.loadNibView()
    
    private var viewModel: MineViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        viewModel = MineViewModel(header: header as! MineHeader, model: nil)
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
}
