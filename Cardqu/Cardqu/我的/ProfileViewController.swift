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
        header.frame = CGRect(x: 0, y: statusBarH, width: screenWidth, height: 280)
        header.backgroundColor = UIColor.clear
        return header
    }()

    var table: UITableView!
    private var tableViewModel = ProfileViewModel()
    
       private var headerViewModel: MineHeaderProtocol! {
        didSet{
            guard let vm = headerViewModel else { return }
            
            let hdv = header as! MineHeader
            hdv.usernameLb.reactive.text <~ vm.nickName
            hdv.qudouLb.reactive.text <~ vm.totalBeans
            hdv.addBeansLb.reactive.text <~ vm.addBeans
            hdv.levelLb.reactive.text <~ vm.level
            hdv.editInfoBtn.reactive.isEnabled <~ vm.editInfoBtnIsEnabled
            hdv.loginSigninBtn.reactive.title <~ vm.btnTitle
            hdv.loginSigninBtn.reactive.isEnabled <~ vm.loginsiginBtnIsEnabled
            
            if vm.headerUrl.value.count > 0 && (vm.headerUrl.value.hasPrefix("https://") || vm.headerUrl.value.hasPrefix("http://")) {
                
                hdv.headerImgView.kf.setImage(with: ImageResource(downloadURL: URL(string: vm.headerUrl.value)!, cacheKey: nil), placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)
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
                    vm.signinProducer.startWithValues({ (value) in
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
        headerViewModel = MineHeaderViewModel()
        headerViewModel.notifi()
        
        loadDataNoMj()
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
        table = UITableView(frame: CGRect(x: 0, y: header.frame.maxY, width: screenWidth, height: screenHeight - header.frame.maxY), style: UITableViewStyle.plain)
        table.separatorStyle = .none
        view.addSubview(table)
    }
}

extension ProfileViewController: ListBinderPotocol{
    var tableView: UITableView {
        return table
    }
    
    var viewModel: ListViewModelProtocol {
        return tableViewModel
    }
    
    var cellClass: AnyClass {
        return ProfileCell.self 
    }
    
    var cellNib: UINib? {
        guard let clsName = ProfileCell.description().components(separatedBy: ".").last else { return nil }
        return UINib(nibName: clsName, bundle: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewModel.allData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ProfileCell.description()) as! ProfileCell
        
        cell.viewModel = tableViewModel.allData[indexPath.row] as? ProfileCellModel
        return cell
    }

}


