//
//  UIView+Extension.swift
//  Cardqu
//
//  Created by qiannianye on 2018/1/24.
//  Copyright © 2018年 qiannianye. All rights reserved.
//

import Foundation


//MARK: loadNib view

protocol LoadNibProtocol {
    
}

extension LoadNibProtocol where Self: UIView {
    static func loadNib(_ nibName: String? = nil) -> Self{
        return Bundle.main.loadNibNamed(nibName ?? "\(self)", owner: nil, options: nil)?.first as! Self
    }
}


extension UIView{
    static func loadNibView<T: UIView>() -> T{
        let className = self.description().components(separatedBy: ".").last
        guard let clsname = className else { return UIView() as! T }
        return Bundle.main.loadNibNamed(clsname, owner: nil, options: nil)?.first as! T
    }
}

//MARK: 圆角
extension UIView{
    //拓展里面不能创建存储型属性.
    //var cornerStyle = UIRectCorner.allCorners
    
    func corner(roundingCorner: UIRectCorner = .allCorners, cornerRadii: CGSize) -> Void {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: roundingCorner, cornerRadii: cornerRadii)
        let shapeLayer = CAShapeLayer()
        shapeLayer.borderColor = UIColor.lightGray.cgColor
        shapeLayer.borderWidth = 1
        shapeLayer.frame = self.bounds
        shapeLayer.path = path.cgPath
        self.layer.mask = shapeLayer
    }
}
