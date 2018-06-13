//
//  LRImgLbComponent.swift
//  Cardqu
//
//  Created by qiannianye on 2018/3/29.
//  Copyright © 2018年 qiannianye. All rights reserved.
//

import UIKit

class LRImgLbComponent: UIView {
    var titleLb = UILabel()
    var imgVw = UIImageView()
    
    var font: CGFloat = 14 //默认是14
    var imgSize: CGSize = CGSize(width: 16, height: 16)//默认16*16,不传的话就是16*16
    var title: String?{
        didSet {
            
        }
    }
    
    init(frame: CGRect, fontSize: CGFloat = 14, imageSize: CGSize = CGSize(width: 16, height: 16)) {
        addSubview(titleLb)
        addSubview(imgVw)
        
        self.font = fontSize
        self.imgSize = imageSize
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LRImgLbComponent {
    func setupFrame() {
        
    }
}
