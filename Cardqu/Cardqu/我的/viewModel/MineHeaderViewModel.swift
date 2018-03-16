//
//  MineHeaderViewModel.swift
//  Cardqu
//
//  Created by qiannianye on 2018/1/24.
//  Copyright © 2018年 qiannianye. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift
import Result
import Kingfisher

enum BtnEvent: String {
    case login = "登录"
    case signin = "签到"
    case hasSignin = "已签到"
}

protocol MineHeaderProtocol {
    func notifi()
    var headerUrl: MutableProperty<String> { get }
    var nickName: MutableProperty<String> { get }
    var level: MutableProperty<String> { get }
    var totalBeans: MutableProperty<String> { get }
    var addBeans: MutableProperty<String> { get }
    var btnTitle: MutableProperty<String> { get }
    var btnIsEnabled : MutableProperty<Bool> { get }
    var signinProducer: AnyAPIProducer { get }
}

extension MineHeaderViewModel: MineHeaderProtocol {}

class MineHeaderViewModel: BaseViewModel {
    
    private(set) var headerUrl = MutableProperty("")
    private(set) var nickName = MutableProperty("")
    private(set) var level = MutableProperty("")
    private(set) var totalBeans = MutableProperty("")
    private(set) var addBeans = MutableProperty("")
    private(set) var btnTitle = MutableProperty("")
    private(set) var btnIsEnabled = MutableProperty(true)
    
    private(set) lazy var signinProducer: AnyAPIProducer = {
        
        return UserAPI().userSignIn().on(value: { [unowned self] (value) in
            let dic = value as! Dictionary<String, Any>
            let add = dic["add_beans"] as! NSNumber
            let total = dic["beans"] as! NSNumber
            self.addBeans.value = String.init(format: "%@", add)
            self.totalBeans.value = String.init(format: "%@", total)
            self.btnTitle.value = "已签到"
            self.model?.has_signed = "1"
        })
    }()
    
    
    var model: VipInfoModel? {
        didSet{
            guard model != nil else { return }
            
            headerUrl.value = UserManager.default.user?.icon_url ?? ""
            nickName.value = UserManager.default.user?.display_name ?? ""
            level.value = model?.level ?? ""
            totalBeans.value = (model?.beans ?? "0") + "趣豆"
            
            if UserManager.default.isVisitor {
                //弹出登录页面
                btnTitle.value = BtnEvent.login.rawValue
                btnIsEnabled.value = true
            }else{
                guard let signin = model?.has_signed else{
                    btnTitle.value = BtnEvent.hasSignin.rawValue
                    btnIsEnabled.value = false
                    return
                }
                
                if signin.isEqualTo("0") {//签到
                    btnTitle.value = BtnEvent.signin.rawValue
                    btnIsEnabled.value = true
                }else{
                    btnTitle.value = BtnEvent.hasSignin.rawValue
                    btnIsEnabled.value = false
                }
            }
        }
    }
    
    
    func notifi() {
        NotificationCenter.default.addObserver(self, selector: #selector(loadUserInfo), name: NSNotification.Name(rawValue: "LoginSuccess"), object: nil)
    }
    
    @objc private func loadUserInfo(){
        UserAPI().userVipInfo(needInfo: "0").startWithValues { [unowned self] (value) in
            self.model = VipInfoModel.deserialize(from: value as? Dictionary)
        }
    }
    
    
    
    /*
    var header: MineHeader? {
        didSet{
            guard header != nil else { return }
            header!.usernameLb.reactive.text <~ nickName
            header!.qudouLb.reactive.text <~ beans
            
            guard headerUrl.value.count > 0 && (headerUrl.value.hasPrefix("https://") || headerUrl.value.hasPrefix("http://")) else {
                return
            }
            header?.headerImgView.kf.setImage(with: ImageResource(downloadURL: URL(string: headerUrl.value)!, cacheKey: nil), placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)
            
            //下载图片,并将图片裁剪成带外边框的圆形.
            //由于给定的默认图片本身就是圆形,再剪裁就会变形,达不到那种带外边框圆形的效果,故而不用这种方式了.
            //换成直接将ImageView剪裁成圆形,然后填充图片.
//            ImageDownloader.default.downloadImage(with: URL(string: headerUrl.value)!, retrieveImageTask: nil, options: nil, progressBlock: nil) { (image, error, url, imgData) in
//                if image != nil {
//
//                    //self.header?.headerImgView.image = image?.circleImage()
//
////                    let rect = CGRect(x: 0, y: 0, width: (self.header?.headerImgView.frame.width)!, height: (self.header?.headerImgView.frame.height)!)
////                    self.header?.headerImgView.image = image?.borderCircleImage(circleRect: rect, borderWidth: 3, borderColor: UIColor.black)
//                }
//            }
            
        }
    }
 */
    
    
}
