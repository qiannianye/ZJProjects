//
//  GoodsShowCell.swift
//  Cardqu
//
//  Created by qiannianye on 2017/11/17.
//  Copyright © 2017年 qiannianye. All rights reserved.
//

import UIKit

class GoodsShowCell: UICollectionViewCell {
    var imgView: UIImageView?
    var priceLb: UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height - 22))
        contentView.addSubview(imgView!)
        
        priceLb = UILabel(frame: CGRect(x: 0, y: (imgView?.frame.maxY)! + 8, width: frame.width, height: 14))
        priceLb?.font = UIFont.systemFont(ofSize: 12)
        contentView.addSubview(priceLb!)
    }
    
    func updateGoodsShowCell(imgUrl: String, price: String) {
        imgView?.sd_setImage(with: URL(string: imgUrl), completed: { (image, error, imageType, url) in
            
        })
        priceLb?.text = price
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
