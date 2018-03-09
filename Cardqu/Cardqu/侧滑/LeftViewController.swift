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
        header.frame = CGRect(x: 0, y: statusBarH, width: screenWidth, height: 200)
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
            hdv.loginBtn.reactive.title <~ viewModel.btnTitle
            
            if viewModel.headerUrl.value.count > 0 && (viewModel.headerUrl.value.hasPrefix("https://") || viewModel.headerUrl.value.hasPrefix("http://")) {
                
                hdv.headerImgView.kf.setImage(with: ImageResource(downloadURL: URL(string: viewModel.headerUrl.value)!, cacheKey: nil), placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)
            }
            
    
            hdv.editBtn.reactive.controlEvents(.touchUpInside).observe { (event) in
                let vc = MyInfoViewController()
                vc.hidesBottomBarWhenPushed = true
                
                let naviVC = UIViewController.slidingPushNaviVC()
                naviVC.pushViewController(vc, animated: true)
            }
            
            hdv.loginBtn.reactive.controlEvents(.touchUpInside).observeValues { (btn) in
                switch self.viewModel.state.value {
                case .login:
                    let loginVC = LoginViewController()
                    self.present(loginVC, animated: true, completion: nil)
                case .sigin:
                    
                    hdv.loginBtn.reactive.pressed = ButtonAction(self.viewModel.signinAction)
                    
                    self.viewModel.signinAction.values.observeValues { [unowned self](value) in
                        UIView.animate(withDuration: 0.25, animations: {
                            hdv.addBeansLb.alpha = 1.0
                            var tmpFrame = hdv.addBeansLb.frame
                            tmpFrame.origin.y = 0
                            hdv.addBeansLb.frame = tmpFrame
                        }, completion: { (finished) in
                            hdv.addBeansLb.alpha = 0.0
                        })
                    }
                case .nothing:
                    break
                }
            }
    
//            hdv.loginBtn.reactive.pressed = ButtonAction(viewModel.loginAction)
//            viewModel.loginAction.values.observeValues { (value) in
//                let state = value as! BtnEventState
//                switch state {
//                case .login:
//                    let loginVC = LoginViewController()
//                    self.present(loginVC, animated: true, completion: nil)
//                case .sigin:
//                    self.viewModel.signinAction.values.observeValues { [unowned self](value) in
//                        UIView.animate(withDuration: 0.25, animations: {
//                            hdv.addBeansLb.alpha = 1.0
//                            var tmpFrame = hdv.addBeansLb.frame
//                            tmpFrame.origin.y = 0
//                            hdv.addBeansLb.frame = tmpFrame
//                        }, completion: { (finished) in
//                            hdv.addBeansLb.alpha = 0.0
//                        })
//                    }
//                case .nothing:
//                    break
//                }
//            }
            
//            hdv.levelBtn.reactive.pressed = ButtonAction(viewModel.levelAction)
//            viewModel.levelAction.values.observeValues { (value) in
//                let vc = LevelViewController(title: "等级和积分", webUrl: "/2.3/vip/pointsAndLevel.html")
//                let window = UIApplication.shared.keyWindow
//                let rootVC = window?.rootViewController as! SlidingMenuVC
//                let naviVC = rootVC.mainVC?.childViewControllers[0] as! UINavigationController
//
//                rootVC.closeLeftMenu(offsetX: screenWidth)
//                vc.hidesBottomBarWhenPushed = true
//                naviVC.pushViewController(vc, animated: true)
//            }
//
            hdv.levelBtn.reactive.controlEvents(UIControlEvents.touchUpInside).observe { (signal) in
                
                let vc = LevelViewController(title: "等级和积分", webUrl: "/2.3/vip/pointsAndLevel.html")
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

extension LeftViewController {
    func setupUI() {
       self.view.backgroundColor = UIColor.white
        view.addSubview(header)
    }
}
