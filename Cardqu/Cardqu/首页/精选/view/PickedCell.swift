//
//  PickedCell.swift
//  Cardqu
//
//  Created by qiannianye on 2018/3/23.
//  Copyright © 2018年 qiannianye. All rights reserved.
//

import UIKit
import Kingfisher
import ReactiveSwift

class PickedCell: UITableViewCell {

    var imgVw = UIImageView()
    var markImgVw = UIImageView()
    lazy var titleLb: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = UIColor.white
        label.textAlignment = NSTextAlignment.center
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var transBgVw: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.black
        v.alpha = 0.2
        return v
    }()
    
    private lazy var lineImgVw: UIImageView = {
        let line = UIImageView()
        line.backgroundColor = UIColor.white
        return line
    }()
    
    var viewModel: PickedCellModel? {
        didSet{
            guard let vm = viewModel else {return}
    
            if vm.isNew.value.isEqualTo("0") {
                markImgVw.alpha = 0.0
            }else{
                markImgVw.alpha = 1.0
            }
            
            imgVw.kf.setImage(with: ImageResource(downloadURL: URL(string: vm.imgUrl.value)!), placeholder:UIImage(named: "placeholder.png"), options: nil, progressBlock: nil, completionHandler: nil)
            
            titleLb.reactive.text <~ vm.title
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(imgVw)
        addSubview(transBgVw)
        addSubview(titleLb)
        addSubview(markImgVw)
        addSubview(lineImgVw)
        
        setNeedsUpdateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setNeedsUpdateConstraints() {
        imgVw.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.height.equalToSuperview()
            make.center.equalToSuperview()
        }
        
        transBgVw.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.height.equalToSuperview()
            make.center.equalToSuperview()
        }
        
        titleLb.snp.makeConstraints { (make) in
            make.left.equalTo(24)
            make.right.equalTo(-24)
            make.top.equalTo(20)
            make.bottom.equalTo(-20)
        }
        
        markImgVw.snp.makeConstraints { (make) in
            make.top.equalTo(8)
            make.left.equalTo(0)
            make.width.equalTo(44)
            make.height.equalTo(18)
        }
        
        lineImgVw.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.height.equalTo(1)
            make.bottom.equalTo(-1)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
