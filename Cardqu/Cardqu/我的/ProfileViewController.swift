//
//  ProfileViewController.swift
//  Cardqu
//
//  Created by qiannianye on 2018/3/15.
//  Copyright © 2018年 qiannianye. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift
import Result
import Kingfisher

class ProfileViewController: BaseViewController {

    let header: UIView = {
        let header = MineHeader.loadNibView()
        header.frame = CGRect(x: 0, y: statusBarH, width: screenWidth, height: 300)
        header.backgroundColor = UIColor.cyan
        return header
    }()
    
       private var viewModel: MineHeaderProtocol! {
        didSet{
            guard viewModel != nil else {
                return
            }
            
            let hdv = header as! MineHeader
            hdv.usernameLb.reactive.text <~ viewModel.nickName
            hdv.qudouLb.reactive.text <~ viewModel.totalBeans
            hdv.addBeansLb.reactive.text <~ viewModel.addBeans
            hdv.levelLb.reactive.text <~ viewModel.level
            hdv.loginSigninBtn.reactive.title <~ viewModel.btnTitle
            hdv.loginSigninBtn.reactive.isEnabled <~ viewModel.btnIsEnabled
            
            if viewModel.headerUrl.value.count > 0 && (viewModel.headerUrl.value.hasPrefix("https://") || viewModel.headerUrl.value.hasPrefix("http://")) {
                
                hdv.headerImgView.kf.setImage(with: ImageResource(downloadURL: URL(string: viewModel.headerUrl.value)!, cacheKey: nil), placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)
            }
            hdv.editInfoBtn.reactive.controlEvents(.touchUpInside).observe { (event) in
                let vc = MyInfoViewController()
                vc.hidesBottomBarWhenPushed = true
                
                let naviVC = UIViewController.slidingPushNaviVC()
                naviVC.pushViewController(vc, animated: true)
            }
           
            hdv.loginSigninBtn.reactive.controlEvents(.touchUpInside).observeValues { (btn) in
                
                guard let title = btn.titleLabel?.text else {return}
                
                switch title {
                case BtnEvent.login.rawValue:
                    let loginVC = LoginViewController()
                    self.present(loginVC, animated: true, completion: nil)
                case BtnEvent.signin.rawValue:
                    
                    btn.isEnabled = false
                    self.viewModel.signinProducer.startWithValues({ (value) in
                        UIView.animate(withDuration: 0.25, animations: {
                            hdv.addBeansLb.alpha = 1.0
                            var tmpFrame = hdv.addBeansLb.frame
                            tmpFrame.origin.y = 0
                            hdv.addBeansLb.frame = tmpFrame
                        }, completion: { (finished) in
                            hdv.addBeansLb.alpha = 0.0
                        })
                    })
                case BtnEvent.hasSignin.rawValue:
                    break
                default:
                    break
                }
            }
            hdv.levelBtn.reactive.controlEvents(UIControlEvents.touchUpInside).observe { (signal) in
                
                let vc = LevelViewController(title: "等级和积分", webUrl: "/2.3/vip/pointsAndLevel.html")
                vc.hidesBottomBarWhenPushed = true
                
                let naviVC = UIViewController.slidingPushNaviVC()
                naviVC.pushViewController(vc, animated: true)
            }
            
            hdv.couponVw.actionBtn.reactive.controlEvents(.touchUpInside).observe { (event) in
                let vc = CouponViewController()
                vc.hidesBottomBarWhenPushed = true
                
                let naviVC = UIViewController.slidingPushNaviVC()
                naviVC.pushViewController(vc, animated: true)
            }
            
            hdv.logoutBtn.reactive.controlEvents(.touchUpInside).observe { (event) in
                CQUser.name = CQVisitor.name
                CQUser.password = ""
                CQUser.saveAccount()
                LoginManager.share.login()
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

extension ProfileViewController {
    func setupUI() {
        self.view.backgroundColor = UIColor.white
        view.addSubview(header)
    }
}
