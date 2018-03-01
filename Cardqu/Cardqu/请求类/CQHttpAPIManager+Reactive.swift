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
    
    @discardableResult
    func producer(confi: HttpRequestConfiguration) -> AnyAPIProducer {
        return AnyAPIProducer({ (observer, _)  in
            self.startRequest(config: confi, success: { respondsData in
                observer.send(value: respondsData as Any)
                observer.sendCompleted()
            }, fail: { error in
                observer.send(error: error)
            })
        }).observe(on: UIScheduler())
    }
}
