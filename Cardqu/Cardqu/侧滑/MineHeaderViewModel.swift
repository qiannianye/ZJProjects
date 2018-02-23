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


class MineHeaderViewModel: BaseViewModel {
    
    private var headerUrl = MutableProperty("")
    private var nickName = MutableProperty("")
    private var level = MutableProperty("")
    private var beans = MutableProperty("")
    
    var model: VipInfoModel? {
        didSet{
            guard model != nil else { return }
            headerUrl.value = (UserManager.default.user?.icon_url)!
            nickName.value = UserManager.default.user?.display_name ?? ""
            level.value = (model?.level)!
            beans.value = (model?.beans)! + "趣豆"
        }
    }
    
    var header: MineHeader? {
        didSet{
            guard header != nil else { return }
            header!.usernameLb.reactive.text <~ nickName
            header!.qudouLb.reactive.text <~ beans
            
//            ImageDownloader.default.downloadImage(with: URL(string: headerUrl.value)!, retrieveImageTask: nil, options: nil, progressBlock: nil) { (image, error, url, imgData) in
//                if image != nil {
//
//                    //self.header?.headerImgView.image = image?.circleImage()
//
////                    let rect = CGRect(x: 0, y: 0, width: (self.header?.headerImgView.frame.width)!, height: (self.header?.headerImgView.frame.height)!)
////                    self.header?.headerImgView.image = image?.borderCircleImage(circleRect: rect, borderWidth: 3, borderColor: UIColor.black)
//                }
//            }
            
            header?.headerImgView.kf.setImage(with: ImageResource(downloadURL: URL(string: headerUrl.value)!, cacheKey: "UserHeaderUrl"), placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)
        }
    }
}
