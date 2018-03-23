//
//  UIColor+Extension.swift
//  Cardqu
//
//  Created by qiannianye on 2018/1/12.
//  Copyright © 2018年 qiannianye. All rights reserved.
//

import Foundation
import UIKit

//十六进制颜色转RGB
extension UIColor{
    static func hexColor(_ hex: String, alpha: CGFloat) -> UIColor {
        var cstr = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased() as NSString
        if cstr.length < 6 {
            return UIColor.clear
        }
        
        if cstr.hasPrefix("0X") {
            cstr = cstr.substring(from: 2) as NSString
        }else if cstr.hasPrefix("#"){
            cstr = cstr.substring(from: 1) as NSString
        }
        
        if cstr.length != 6 {
            return UIColor.clear
        }
        
        var range = NSRange()
        range.location = 0
        range.length = 2
        
        let rStr = cstr.substring(with: range)
        
        range.location = 2
        
        let gStr = cstr.substring(with: range)
        
        range.location = 4
        
        let bStr = cstr.substring(with: range)
        
        var r: UInt32 = 0x0
        var g: UInt32 = 0x0
        var b: UInt32 = 0x0
        
        Scanner(string: rStr).scanHexInt32(&r) //扫描字符串将其转成整型存放在r里
        Scanner(string: gStr).scanHexInt32(&g)
        Scanner(string: bStr).scanHexInt32(&b)
        
//        let result = CGFloat(r) / 255.0
//        let result2 = CGFloat(r) / 255
        // 除以255, 或255.0,结果一样
        
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: alpha)
    }
}

//颜色转image
extension UIColor{
    var image: UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(cgColor)
        context?.fill(rect)
        let img = context?.makeImage()
        UIGraphicsEndImageContext()
        return UIImage(cgImage: img!)
    }
}
