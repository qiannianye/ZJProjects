//
//  MineHeader.swift
//  Cardqu
//
//  Created by qiannianye on 2018/1/23.
//  Copyright © 2018年 qiannianye. All rights reserved.
//

import UIKit

import ReactiveCocoa
import ReactiveSwift
import Result
import Kingfisher

class MineHeader: UIView,LoadNibProtocol {
    
    @IBOutlet weak var headerImgView: UIImageView!
    @IBOutlet weak var editInfoBtn: UIButton!
    
    @IBOutlet weak var usernameLb: UILabel!
    @IBOutlet weak var qudouLb: UILabel!

    @IBOutlet weak var addBeansLb: UILabel!
    @IBOutlet weak var loginSigninBtn: UIButton!
    
    @IBOutlet weak var levelLb: UILabel!
    @IBOutlet weak var levelBtn: UIButton!
    
    @IBOutlet weak var couponVw: ImgLbComponent!
    @IBOutlet weak var orderVw: ImgLbComponent!
    @IBOutlet weak var messageVw: ImgLbComponent!
    
    @IBOutlet weak var logoutBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setNeedsUpdateConstraints()
        
        self.headerImgView.clipsToBounds = true
        self.headerImgView.layer.cornerRadius = self.headerImgView.frame.width/2
        self.headerImgView.layer.borderColor = UIColor.black.cgColor
        self.headerImgView.layer.borderWidth = 1
        
        self.loginSigninBtn.clipsToBounds = true
        self.loginSigninBtn.layer.cornerRadius = 6
        self.loginSigninBtn.layer.borderWidth = 1
        self.loginSigninBtn.layer.borderColor = UIColor.orange.cgColor
        
        guard let imgVw = couponVw.imgView,
            let ttLb = couponVw.titleLb,
            let bdLb = couponVw.badgeLb
        else { return }
        imgVw.image = UIImage(named: "my_coupons_icon")
        ttLb.text = "我的优惠券"
        bdLb.text = "20"
        
        guard let imgVw2 = orderVw.imgView,
            let ttLb2 = orderVw.titleLb,
            let bdLb2 = orderVw.badgeLb
            else { return }
        imgVw2.image = UIImage(named: "my_orders_icon")
        ttLb2.text = "我的订单"
        bdLb2.text = "99+"
        
        guard let imgVw3 = messageVw.imgView,
            let ttLb3 = messageVw.titleLb,
            let bdLb3 = messageVw.badgeLb
            else { return }
        imgVw3.image = UIImage(named: "my_message_icon")
        ttLb3.text = "我的消息"
        bdLb3.text = "9"
    }
    
    override func setNeedsUpdateConstraints() {
        super.setNeedsUpdateConstraints()

        let width = (screenWidth - 24 - 44)/3
        couponVw.snp.updateConstraints { (make) in
            make.width.equalTo(width)
        }

        orderVw.snp.updateConstraints { (make) in
            make.width.equalTo(width)
        }

        messageVw.snp.updateConstraints { (make) in
            make.width.equalTo(width)
        }
    }

}
