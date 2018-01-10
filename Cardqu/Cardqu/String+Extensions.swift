//
//  String+Extensions.swift
//  Cardqu
//
//  Created by qiannianye on 2017/12/5.
//  Copyright © 2017年 qiannianye. All rights reserved.
//

import Foundation

extension String{
    
    //不加private或者fileprivate,默认是public
     var isValidPhoneNum: Bool{
        /**
         * 手机号码
         * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
         * 联通：130,131,132,152,155,156,185,186
         * 电信：133,1349,153,180,189
         */
        let mobile = "^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$"
        
        /**
         * 中国移动：China Mobile
         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
         */
        let cm = "^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$"
        
        /**
         * 中国联通：China Unicom
         * 130,131,132,152,155,156,185,186
         */
        let cu = "^1(3[0-2]|5[256]|8[56])\\d{8}$"
        
        /**
         * 中国电信：China Telecom
         * 133,1349,153,180,189
         */
        let ct = "^1((33|53|8[09])[0-9]|349)\\d{7}$"
        
        return NSPredicate(format: "SELF MATCHES %@", mobile).evaluate(with: self) ||
            NSPredicate(format:"SELF MATCHES %@", cm).evaluate(with: self) ||
            NSPredicate(format:"SELF MATCHES %@", cu).evaluate(with: self) ||
            NSPredicate(format:"SELF MATCHES %@", ct).evaluate(with: self)
    }
}

extension String{
    //MARK:判断是否相等
    func isEqualTo (_ str: String) -> Bool {
        let compareResult = compare(str)
        if compareResult != .orderedSame {
            return false
        }
        return true
    }
    
    //MARK:截取字符串
    func substringTo (_ to: Int) -> String {
        guard to < count else {
            return self
        }
        return String(prefix(upTo: index(startIndex, offsetBy: to)))
    }
    
    func substringFrom (_ from: Int) -> String {
        guard from <= count else {
            return self
        }
        return String(suffix(from: index(startIndex, offsetBy: from)))
    }
}
