//
//  MyInfoCell.swift
//  Cardqu
//
//  Created by qiannianye on 2018/3/14.
//  Copyright © 2018年 qiannianye. All rights reserved.
//

import UIKit
import ReactiveSwift
import Kingfisher

class MyInfoCell: UITableViewCell, LoadNibProtocol {

    @IBOutlet weak var titleLb: UILabel!
    @IBOutlet weak var contentLb: UILabel!
    @IBOutlet weak var arrowImgVw: UIImageView!
    @IBOutlet weak var infoImgVw: UIImageView!
    @IBOutlet weak var lineImgVw: UIImageView!
    
    var viewModel: MyInfoCellModel?{
        didSet {
            guard let vm = viewModel else { return }
            
            titleLb.reactive.text <~ vm.title
            contentLb.reactive.text <~ vm.content
        }
    }
    
    var imgViewModel: MyInfoCellModel?{
        didSet{
            guard let vm = imgViewModel else {return}
            
            titleLb.reactive.text <~ vm.title
            
            if vm.content.value.hasPrefix("https://") || vm.content.value.hasPrefix("http://") {
                ImageDownloader.default.downloadImage(with: URL(string:vm.content.value)!, retrieveImageTask: nil, options: nil, progressBlock: nil, completionHandler: { [unowned self] (image, error, imgUrl, imgData) in
                    if image != nil {
                        self.infoImgVw.image = image!
                    }
                })
            }else{
                infoImgVw.reactive.image <~ MutableProperty(UIImage(named: "my_head_icon_1"))
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        infoImgVw.clipsToBounds = true
        infoImgVw.layer.cornerRadius = infoImgVw.frame.width / 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
