//
//  MyinfoSection.swift
//  Cardqu
//
//  Created by qiannianye on 2018/3/20.
//  Copyright © 2018年 qiannianye. All rights reserved.
//

import UIKit

class MyinfoSection: UIView {
    
    let titleLb = UILabel(frame: CGRect.zero)
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.hexColor("fafafa", alpha: 1.0)
        
        titleLb.frame = CGRect(x: 12, y: 0, width: frame.width - 24, height: frame.height)
        titleLb.font = UIFont.systemFont(ofSize: 15)
        addSubview(titleLb)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
