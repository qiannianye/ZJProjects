//
//  UIImage+Drawing.swift
//  Cardqu
//
//  Created by qiannianye on 2018/1/23.
//  Copyright © 2018年 qiannianye. All rights reserved.
//

import Foundation


extension UIImage{
    
    func borderCircleImage(circleRect: CGRect, borderWidth: CGFloat, borderColor: UIColor) -> UIImage {
        //开启上下文
        UIGraphicsBeginImageContext(self.size)

        //设置边框
        var rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        if circleRect.width > self.size.width {
            rect = circleRect
        }
        
        let path = UIBezierPath(ovalIn: rect)
        borderColor.setFill()
        path.fill()
        
        //设置剪裁区域
        let clipPath = UIBezierPath(ovalIn: CGRect(x: rect.origin.x + borderWidth, y: rect.origin.x + borderWidth, width: rect.width - borderWidth * 2, height: rect.height - borderWidth * 2))
        clipPath.addClip()
        
        //绘制图片
        self.draw(at: CGPoint.zero)
        
        //获取新图片
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        //关闭上下文
        UIGraphicsEndImageContext()
        
        //返回新图片
        return newImage!
    }
 
    
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
