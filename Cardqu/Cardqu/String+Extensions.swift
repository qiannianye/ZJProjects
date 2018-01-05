//
//  String+Extensions.swift
//  Cardqu
//
//  Created by qiannianye on 2017/12/5.
//  Copyright © 2017年 qiannianye. All rights reserved.
//

import Foundation

extension String{
    //MARK:判断是否相等
    func isEqualTo(_ str: String) -> Bool {
        let compareResult = compare(str)
        if compareResult != .orderedSame {
            return false
        }
        return true
    }
}
