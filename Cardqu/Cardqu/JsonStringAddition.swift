//
//  JsonStringAddition.swift
//  Cardqu
//
//  Created by qiannianye on 2017/12/13.
//  Copyright © 2017年 qiannianye. All rights reserved.
//

import UIKit

class JsonStringAddition: NSString {
    //MARK:字典转字符串
    static func converDicToString(dic: [String : AnyObject]) -> String {
        var result = ""
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dic, options: .prettyPrinted)
            if let jsonStr = String(data: jsonData, encoding: String.Encoding.utf8) {
                result = jsonStr
            }
        } catch  {
            
        }
        return result
    }
    
    //MARK:数组转字符串
    //问题:不带static 关键字时是实例方法,不可以直接类调用,只能实例调用.
    //带static 关键字是静态方法,也就是类方法.才可以直接类调用.
    static func convertArrayToString(arr: [AnyObject]) -> String {
        var result = ""
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: arr, options: .init(rawValue: 0))
            if let jsonStr = String(data: jsonData, encoding:String.Encoding.utf8){//没有该方法?!
                result = jsonStr
            }
        } catch {
            result = ""
        }
        return result
    }
}
