//
//  String+Extensions.swift
//  Cardqu
//
//  Created by qiannianye on 2017/12/5.
//  Copyright © 2017年 qiannianye. All rights reserved.
//

import Foundation

extension String{
    static func contentWidth(content: String, font: CGFloat, height: CGFloat) -> CGSize {
        let nstr = content as NSString
        return nstr.boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: height), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: font)], context: nil).size
    }
    
    static func contentHeight(content: String, font: CGFloat, width: CGFloat) -> CGSize {
        let nstr = content as NSString
        return nstr.boundingRect(with: CGSize(width:width , height: CGFloat(MAXFLOAT)), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: font)], context: nil).size
    }
}

//MARK: 文件路经
extension String{
    static func filePath(fileName: String) -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)
        let path = paths[0] as NSString
        return path.appendingPathComponent(fileName)
    }
}

//MARK: 合法性判断
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

//MARK:操作字符串
extension String{
    //判断是否相等
    func isEqualTo (_ str: String) -> Bool {
        let compareResult = compare(str)
        if compareResult != .orderedSame {
            return false
        }
        return true
    }
    
    //截取字符串
    func substringTo (_ to: Int) -> String {
        guard to < count else {
            return self
        }
        return String(prefix(upTo: index(startIndex, offsetBy: to)))
    }
    
    //截取字符串
    func substringFrom (_ from: Int) -> String {
        guard from <= count else {
            return self
        }
        return String(suffix(from: index(startIndex, offsetBy: from)))
    }
}
