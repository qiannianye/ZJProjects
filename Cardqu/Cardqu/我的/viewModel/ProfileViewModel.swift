//
//  ProfileViewModel.swift
//  Cardqu
//
//  Created by qiannianye on 2018/3/19.
//  Copyright © 2018年 qiannianye. All rights reserved.
//

import Foundation
import ReactiveSwift

class ProfileViewModel: ListViewModel {
    override func fetchDataSignal(_ page: Int, _ pageSize: Int) -> SignalProducer<[ListCellModelProtocol], APIError> {
        return APIProducer{(observer,_) in
            let imgArr = ["favorite","interestingbean","recommend","vipcard","customerservice","settings"] //my_favorite_icon
            let titleArr = ["我的收藏","趣豆商城","推荐有礼","会员卡","客服与反馈","设置"]
            var dataArr = [ListCellModelProtocol]()
            for i in 0...(imgArr.count - 1){
                let model = InfoModel()
                model.imgName = "my_" + imgArr[i] + "_icon"
                model.title = titleArr[i]
                
                dataArr.append(ProfileCellModel(model: model))
            }
            
            observer.send(value: dataArr)
            observer.sendCompleted()
        }
    }
}
