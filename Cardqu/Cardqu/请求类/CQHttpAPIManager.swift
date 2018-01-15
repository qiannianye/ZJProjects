//
//  CQHttpAPIManager.swift
//  Cardqu
//
//  Created by qiannianye on 2018/1/11.
//  Copyright © 2018年 qiannianye. All rights reserved.
//

import Foundation
import ReactiveSwift
import Result

class HttpAPIManager {
    func startRequest(config: HttpRequestConfiguration, success: @escaping RequestSuccessBlock, fail: @escaping RequestFailBlock) {
        HttpRequestManager.shared.baseRequestWithConfig(config: config, success: { (respondsData) in
            success(respondsData)
        }) { (error) in
            fail(error)
        }
    }
}

