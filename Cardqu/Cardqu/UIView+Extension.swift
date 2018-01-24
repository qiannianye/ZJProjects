//
//  UIView+Extension.swift
//  Cardqu
//
//  Created by qiannianye on 2018/1/24.
//  Copyright © 2018年 qiannianye. All rights reserved.
//

import Foundation


//MARK: loadNib view
extension UIView{
    static func loadNibView<T: UIView>() -> T {
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
        shapeLayer.frame = self.bounds
        shapeLayer.path = path.cgPath
        self.layer.mask = shapeLayer
    }
}
