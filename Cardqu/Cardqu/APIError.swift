//
//  APIError.swift
//  Cardqu
//
//  Created by qiannianye on 2018/2/24.
//  Copyright © 2018年 qiannianye. All rights reserved.
//

import Foundation

protocol ErrorRawValue {
    var rawValue: Int { get }
}

extension Int: ErrorRawValue{
    var rawValue: Int { return self }
}

enum TaskError: Int,ErrorRawValue {
    case `default` = 101
    case timeout
    case canceled
    case noNetwork
    case noData
    case noMoreData
}

struct APIError: Error {
    var code: Int
    var info = ""
    var reason: String {
        switch code {
        case TaskError.timeout.rawValue:
            return "请求超时~"
        case TaskError.noNetwork.rawValue:
            return "未检测到网络连接~"
        case TaskError.noData.rawValue:
            return "空空如也~"
        case TaskError.noMoreData.rawValue:
            return "没有更多数据~"
        default:
            return info.count > 0 ? info : "请求失败~"
        }
    }
    
    init(_ error: ErrorRawValue) {
        self.code = error.rawValue
    }
}
