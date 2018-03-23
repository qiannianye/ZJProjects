//
//  AdsViewModel.swift
//  Cardqu
//
//  Created by qiannianye on 2018/3/21.
//  Copyright © 2018年 qiannianye. All rights reserved.
//

import Foundation
import ReactiveSwift


class AdsViewModel: BaseViewModel{
    
    override func fetchSignal() -> AnyAPIProducer {
        return RecommendAPI().ads(postId: "10000").map({(value) -> [AnyObject] in
            let dic = value as! NSDictionary
            guard let arr = dic["ads"] else {return [AnyObject]()}
            
            var resultArr = [AnyObject]()
            for item in arr as! NSArray{
                let model = AdModel.deserialize(from: item as? NSDictionary)
                resultArr.append(model! as AnyObject)
            }
            return resultArr
        })
    }
    
     @objc private func adsData() {
        self.fetchAction.apply(nil).start()
    }
    
    func notify() {
        NotificationCenter.default.addObserver(self, selector: #selector(adsData), name: NSNotification.Name(rawValue: "LoginSuccess"), object: nil)
    }
}
