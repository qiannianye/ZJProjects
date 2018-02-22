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
    func banner() -> SignalProducer<Any?,NoError> {
        let confi = HttpRequestConfiguration(url: "/2.3/slot/10000/ads.json", method: .get, parameters:[:], isToken: false)
        return producer(confi: confi)
    }
}
