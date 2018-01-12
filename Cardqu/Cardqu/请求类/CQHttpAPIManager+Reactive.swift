//
//  CQHttpAPIManager+Reactive.swift
//  Cardqu
//
//  Created by qiannianye on 2018/1/12.
//  Copyright © 2018年 qiannianye. All rights reserved.
//

import Foundation

import ReactiveSwift
import Result

extension Cardqu.HttpAPIManager {
    
//    @discardableResult
//    public func producer(configuration config: HttpRequestConfiguration) -> SignalProducer<Any?,NoError>{
//        return SignalProducer({(subscriber, _) in
//
//            self.startRequest(config: config, success: { (value) in
//                subscriber.send(value: value)
//                subscriber.sendCompleted()
//            }, fail: { (error) in
//                subscriber.send(error: error as! NoError) //转化失败,崩溃
//            })
//        }).observe(on: UIScheduler())
//    }
    
    @discardableResult
    func producer(confi: HttpRequestConfiguration) -> SignalProducer<Any?,NoError> {
        return SignalProducer({ (observer, _)  in
            self.startRequest(config: confi, success: { respondsData in
                observer.send(value: respondsData as Any)
                observer.sendCompleted()
            }, fail: { error in
                observer.send(error: error as! NoError)
            })
        }).observe(on: UIScheduler())
    }
}
