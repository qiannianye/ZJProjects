//
//  MonthRecmmdViewModel.swift
//  Cardqu
//
//  Created by qiannianye on 2018/3/22.
//  Copyright © 2018年 qiannianye. All rights reserved.
//

import Foundation

class MonthRecmmdViewModel: BaseViewModel {
    override func fetchSignal() -> AnyAPIProducer {
        return RecommendAPI().monthRecommend().map({ (value) -> [AnyObject] in
            
            let dic = value as! NSDictionary
            var resultArr = [AnyObject]()
            guard let arr = dic["recommends"] else {return resultArr}
            
            for item in arr as! NSArray{
                let model = MonthRecmmdModel.deserialize(from: item as? NSDictionary)
                resultArr.append(model! as AnyObject)
            }
            return resultArr
        })
    }
}
