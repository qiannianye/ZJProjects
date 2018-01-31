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
        let header = ["Authorization":"Bearer \(String(describing: UserManager.default.user?.access_token))"]
        let confi = HttpRequestConfiguration(url: "/2.3/slot/10000/ads.json", method: .get, headers: header, parameters:[:] , paraEncoding: URLEncoding.default)
        return producer(confi: confi)
    }
}
