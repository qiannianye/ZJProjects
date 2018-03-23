//
//  ProfileCell.swift
//  Cardqu
//
//  Created by qiannianye on 2018/3/19.
//  Copyright © 2018年 qiannianye. All rights reserved.
//

import UIKit
import ReactiveSwift

class ProfileCell: UITableViewCell {
    
    @IBOutlet weak var titleLb: UILabel!
    @IBOutlet weak var iconImgVw: UIImageView!
    
    var viewModel: ProfileCellModel?{
        didSet{
            guard let vm = viewModel else { return }
            
            iconImgVw.reactive.image <~ MutableProperty(UIImage(named: vm.imgName.value))
            titleLb.reactive.text <~ vm.title
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.backgroundColor = UIColor.hexColor("fafafa", alpha: 1.0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
