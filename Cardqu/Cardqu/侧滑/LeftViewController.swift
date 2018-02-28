//
//  LeftViewController.swift
//  Cardqu
//
//  Created by qiannianye on 2017/11/7.
//  Copyright © 2017年 qiannianye. All rights reserved.
//

import UIKit

import ReactiveCocoa
import ReactiveSwift
import Result
import Kingfisher

class LeftViewController: UIViewController {
    
    let header: UIView = {
        let header = MineHeader.loadNibView()
        header.frame = CGRect(x: 0, y: statusBarH, width: screenWidth, height: 150)
        return header
    }()

    private var viewModel: MineHeaderProtocol! {
        didSet{
            guard viewModel != nil else {
                return
            }
            let hdv = header as! MineHeader
            hdv.usernameLb.reactive.text <~ viewModel.nickName
            hdv.qudouLb.reactive.text <~ viewModel.beans
            
            guard viewModel.headerUrl.value.count > 0 && (viewModel.headerUrl.value.hasPrefix("https://") || viewModel.headerUrl.value.hasPrefix("http://")) else {
                return
            }
            hdv.headerImgView.kf.setImage(with: ImageResource(downloadURL: URL(string: viewModel.headerUrl.value)!, cacheKey: nil), placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)
            
            hdv.loginBtn.reactive.pressed = CocoaAction(viewModel.loginAction, input: hdv.loginBtn)
            viewModel.loginAction.values.observeValues { (value) in
                let state = value as! BtnEventState
                switch state {
                case .login:
                    let loginVC = LoginViewController()
                    self.present(loginVC, animated: true, completion: nil)
                case .sigin: break
                    
                case .nothing: break
                    
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        viewModel = MineHeaderViewModel()
        viewModel.notifi()
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
}
