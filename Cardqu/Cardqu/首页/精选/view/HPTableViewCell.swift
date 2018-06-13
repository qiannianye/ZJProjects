//
//  HPTableViewCell.swift
//  Cardqu
//
//  Created by qiannianye on 2018/3/26.
//  Copyright © 2018年 qiannianye. All rights reserved.
//

import UIKit

class HPTableViewCell: UITableViewCell {

    var autoSV: CustomScrollView?
    var models = [SubjectModel](){
        didSet{
            guard models.count > 0 else {return}
            
            autoSV?.images = models.map { (model) -> String in
                return model.img_url
            }
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        autoSV = CustomScrollView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 150), scroll: .circle, imgStyle: .scaling)
        autoSV?.backgroundColor = UIColor.brown
        contentView.addSubview(autoSV!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
