//
//  ImgLbComponent.swift
//  Cardqu
//
//  Created by qiannianye on 2018/3/9.
//  Copyright © 2018年 qiannianye. All rights reserved.
//

import UIKit

class ImgLbComponent: UIView {
    
    @IBOutlet var view: UIView!

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLb: UILabel!
    @IBOutlet weak var badgeLb: UILabel!
    @IBOutlet weak var actionBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        badgeLb.clipsToBounds = true
        badgeLb.layer.cornerRadius = badgeLb.frame.height/2
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initViewFromNib()
    }

    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        initViewFromNib()
    }
    
    private func initViewFromNib(){
    
        let nib = UINib(nibName: "ImgLbComponent", bundle: Bundle(for: type(of: self)))
        view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        view.frame = bounds
        self.addSubview(view)
    }
}
