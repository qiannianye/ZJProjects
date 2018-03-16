//
//  MyInfoCell.swift
//  Cardqu
//
//  Created by qiannianye on 2018/3/14.
//  Copyright © 2018年 qiannianye. All rights reserved.
//

import UIKit
import ReactiveSwift

class MyInfoCell: UITableViewCell, LoadNibProtocol {

    @IBOutlet weak var titleLb: UILabel!
    @IBOutlet weak var contentLb: UILabel!
    @IBOutlet weak var arrowImgVw: UIImageView!
    
    var viewModel: MyInfoCellModel?{
        didSet {
            guard let vm = viewModel else { return }
            
            titleLb.reactive.text <~ vm.title
            contentLb.reactive.text <~ vm.content
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
