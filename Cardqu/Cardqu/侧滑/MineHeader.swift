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

class MineHeader: UIView {
    
    @IBOutlet weak var headerImgView: UIImageView!
    @IBOutlet weak var usernameLb: UILabel!
    @IBOutlet weak var qudouLb: UILabel!

    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var editBtn: UIButton!
    
    var viewModel: MineHeaderProtocol! {
        didSet{
            guard viewModel != nil else {
                return
            }
            usernameLb.reactive.text <~ viewModel.nickName
            qudouLb.reactive.text <~ viewModel.beans
            
            guard viewModel.headerUrl.value.count > 0 && (viewModel.headerUrl.value.hasPrefix("https://") || viewModel.headerUrl.value.hasPrefix("http://")) else {
                return
            }
            headerImgView.kf.setImage(with: ImageResource(downloadURL: URL(string: viewModel.headerUrl.value)!, cacheKey: nil), placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.headerImgView.clipsToBounds = true
        self.headerImgView.layer.cornerRadius = self.headerImgView.frame.width/2
        self.headerImgView.layer.borderColor = UIColor.black.cgColor
        self.headerImgView.layer.borderWidth = 1
    }
}
