//
//  ImgLbComponent.swift
//  Cardqu
//
//  Created by qiannianye on 2018/3/9.
//  Copyright © 2018年 qiannianye. All rights reserved.
//

import UIKit

class ImgLbComponent: UIView {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLb: UILabel!
    
    private let imgSize: CGSize
    
    init(frame: CGRect, imageSize: CGSize) {
        
        self.imgSize = imageSize
        super.init(frame: frame)
        setNeedsUpdateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setNeedsUpdateConstraints() {
        imageView.snp.updateConstraints { (make) in
            make.size.equalTo(imgSize)
        }
    }
}
