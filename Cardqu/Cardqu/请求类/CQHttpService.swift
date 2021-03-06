//
//  CQHttpService.swift
//  Cardqu
//
//  Created by qiannianye on 2018/1/11.
//  Copyright © 2018年 qiannianye. All rights reserved.
//

import Foundation

enum CQServiceEnvironment {
    
    case test
    case online
    
    var host: String{
        switch self {
        case .test:
            return "https://apijava.t.cardqu.com/KaQuService"
        default:
            return "https://apijava.cardqu.com/KaQuService"
        }
    }
}


