//
//  MineHeader.swift
//  Cardqu
//
//  Created by qiannianye on 2018/1/23.
//  Copyright © 2018年 qiannianye. All rights reserved.
//

import UIKit

class MineHeader: UIView {
    
    @IBOutlet weak var headerImgView: UIImageView!
    @IBOutlet weak var usernameLb: UILabel!
    @IBOutlet weak var qudouLb: UILabel!

    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var editBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.headerImgView.clipsToBounds = true
        self.headerImgView.layer.cornerRadius = self.headerImgView.frame.width/2
        self.headerImgView.layer.borderColor = UIColor.black.cgColor
        self.headerImgView.layer.borderWidth = 1
    }
}
