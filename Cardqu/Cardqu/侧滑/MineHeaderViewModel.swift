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

protocol MineHeaderProtocol {
    var headerUrl: MutableProperty<String> { get }
    var nickName: MutableProperty<String> { get }
    var level: MutableProperty<String> { get }
    var beans: MutableProperty<String> { get }
    //var loginAction: AnyAPIAction { get }
}

extension MineHeaderViewModel: MineHeaderProtocol {}

class MineHeaderViewModel: BaseViewModel {
    
    private(set) var headerUrl = MutableProperty("")
    private(set) var nickName = MutableProperty("")
    private(set) var level = MutableProperty("")
    private(set) var beans = MutableProperty("")
    
    //private(set) var loginAction: AnyAPIAction = AnyAPIAction(enabledIf: ppty, execute: <#T##(Any?) -> SignalProducer<Any?, APIError>#>)
    
    
    private var loginProducer: AnyAPIProducer {
        if UserManager.default.isVisitor {
            //弹出登录页面
        }else{
            
            if let sign = model?.has_signed {
                if sign.isEqualTo("0") {
                    //签到
                }
            }
        }
    }
    
    private var ppty: Property<Bool> {
        
        var enable = false
        
        if UserManager.default.isVisitor {
            enable = true
        }else{
            guard let sign = model?.has_signed else { return Property.init(value: false) }
            
            if sign.isEqualTo("0"){
                enable = true
            }else{
                enable = false
            }
        }
        return Property.init(value: enable)
    }
    
    
    
    var model: VipInfoModel? {
        didSet{
            guard model != nil else { return }
            headerUrl.value = UserManager.default.user?.icon_url ?? ""
            nickName.value = UserManager.default.user?.display_name ?? ""
            level.value = model?.level ?? ""
            beans.value = (model?.beans ?? "0") + "趣豆"
        }
    }
    
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
}
