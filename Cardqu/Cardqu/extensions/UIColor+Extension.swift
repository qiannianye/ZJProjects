//
//  UIColor+Extension.swift
//  Cardqu
//
//  Created by qiannianye on 2018/1/12.
//  Copyright © 2018年 qiannianye. All rights reserved.
//

import Foundation
import UIKit

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
