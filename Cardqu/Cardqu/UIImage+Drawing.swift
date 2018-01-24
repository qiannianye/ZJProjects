//
//  UIImage+Drawing.swift
//  Cardqu
//
//  Created by qiannianye on 2018/1/23.
//  Copyright © 2018年 qiannianye. All rights reserved.
//

import Foundation


extension UIImage{
    func circleImage() -> UIImage {
//        UIGraphicsBeginImageContextWithOptions(self.size, false, 0)
//        let path = UIBezierPath(roundedRect: CGRect(x:0,y:0,width:size.width,height:size.height), cornerRadius: size.width/2)
//        path.addClip()
//        self.draw(at: .zero)
//        let newImage = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        return newImage!
        
        
        UIGraphicsBeginImageContextWithOptions(self.size, false, 0)
        let currentContext = UIGraphicsGetCurrentContext()
        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        currentContext?.addEllipse(in: rect)
        currentContext?.clip()
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}
