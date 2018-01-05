//
//  GoodsHeaderView.swift
//  Cardqu
//
//  Created by qiannianye on 2017/11/17.
//  Copyright © 2017年 qiannianye. All rights reserved.
//

import UIKit

class GoodsHeaderView: UICollectionReusableView {
    var titleLb: UILabel?
    override func setNeedsDisplay() {
        super.setNeedsDisplay()
        titleLb = UILabel(frame: CGRect(x: 12, y: 0, width: 44, height: frame.height))
        addSubview(titleLb!)
        
        let btn = UIButton(type: .custom)
        btn.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        btn.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
    }
    
    func updateGoodsHeader(title: String) {
        titleLb?.text = title
    }
    
    @objc func btnClick(){
        print("button clicked!")
    }
}
