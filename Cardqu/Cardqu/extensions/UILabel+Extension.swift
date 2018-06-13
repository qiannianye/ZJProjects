//
//  UILabel+Extension.swift
//  Cardqu
//
//  Created by qiannianye on 2018/3/29.
//  Copyright © 2018年 qiannianye. All rights reserved.
//

import Foundation

extension UILabel {
    static func customLabel(frame: CGRect, font: CGFloat, textAlig: NSTextAlignment, textColor: UIColor, numberLines: Int) -> UILabel{
        let label = UILabel(frame: frame)
        label.font = UIFont.systemFont(ofSize: font)
        label.textAlignment = textAlig
        label.textColor = textColor
        label.numberOfLines = numberLines
        return label
    }
}

