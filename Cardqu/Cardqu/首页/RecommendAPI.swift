//
//  RecommendAPI.swift
//  Cardqu
//
//  Created by qiannianye on 2018/1/31.
//  Copyright © 2018年 qiannianye. All rights reserved.
//

import Foundation

import ReactiveSwift
import Result
import Alamofire

class RecommendAPI: HttpAPIManager {
    //banner
    func ads(postId: String) -> AnyAPIProducer {
        let confi = HttpRequestConfiguration(url: "/2.3/slot/\(postId)/ads.json", method: .get, paraDic: nil, isToken: true)
        return producer(confi: confi)
    }
    
    //月度推荐
    func monthRecommend() -> AnyAPIProducer {
        let confi = HttpRequestConfiguration(url: "/2.3/prepay/recommend/index.json", method: .get, paraDic: nil, isToken: false, isCache: true)
        return producer(confi: confi)
    }
    
    //精选
    func pickedRecommend() -> APIProducer<[PickedModel]> {
        let confi = HttpRequestConfiguration(url: "/3.0/posts/mainSubjectsPosts.json", method: .get, paraDic: nil, isToken: false, isCache: true)
        
        return APIProducer({ (observer, _)  in
            self.startRequest(config: confi, success: { (resp) in
                let dic = resp as! NSDictionary
                guard let pickedArr = dic["posts"] else {return}
                
                var resultArr = [PickedModel]()
                for item in pickedArr as! NSArray{
                    let model = PickedModel.deserialize(from: item as? NSDictionary)
                    resultArr.append(model!)
                }
                observer.send(value: resultArr)
                observer.sendCompleted()
            }, fail: { (error) in
                observer.send(error: error)
            })
        }).observe(on: UIScheduler())
    }
}
