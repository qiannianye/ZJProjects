//
//  ImageCollectionCell.swift
//  CircleScrollDemo
//
//  Created by qiannianye on 2018/3/27.
//  Copyright © 2018年 qiannianye. All rights reserved.
//

import UIKit
import Kingfisher

class ImageCollectionCell: UICollectionViewCell {
    
    var imgVw = UIImageView()
    var imgUrl: String? {
        didSet{
            guard let url = imgUrl else { return }
            
            if url.hasPrefix("http://") || url.hasPrefix("https://") {
                imgVw.kf.setImage(with: ImageResource(downloadURL: URL(string: url)!), placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)
            }else{
                imgVw.image = UIImage(named: url)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        imgVw.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        addSubview(imgVw)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

