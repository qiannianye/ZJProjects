//
//  CustomSegment.swift
//  Cardqu
//
//  Created by qiannianye on 2017/11/14.
//  Copyright © 2017年 qiannianye. All rights reserved.
//

import UIKit

class CustomSegment: UIView {
    var delegate: CustomSegmentDelegate? = nil
    var btnArr = [UIButton]()
    
    init(frame: CGRect,segments: [String],_: ()){
        super.init(frame:frame)
        self.backgroundColor = UIColor.white
        var lastOriginX: CGFloat = 0.0
        let btnWidth = frame.size.width/CGFloat(segments.count)
        var index = -1
        for title in segments {
            let btn  = UIButton(type: .custom)
            btn.frame = CGRect(x: lastOriginX, y: 0, width: btnWidth, height: frame.size.height)
            btn.setTitle(title, for: .normal)
            btn.setTitleColor(UIColor.gray, for: .normal)
            btn.setTitleColor(UIColor.orange, for: .selected)
            btn.addTarget(self, action: #selector(segmentClick(btn:)), for: .touchUpInside)
            addSubview(btn)
            lastOriginX = btn.frame.maxX
            btnArr.append(btn)
            index += 1
            btn.tag = index
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(scrollNotification(notify:)), name: NSNotification.Name(rawValue: "DidScroll"), object: nil)
    }
    
    @objc func segmentClick(btn: UIButton) {
        for segbtn in btnArr {
            if btn.isEqual(segbtn) {
                segbtn.isSelected = true
            }else{
                segbtn.isSelected = false
            }
        }
        delegate?.segmentClicked(index: btn.tag)
    }
    
    @objc func scrollNotification(notify: Notification) {
        let dic = notify.userInfo
        let index: Int = dic!["scrollIndex"] as! Int
        let btn = btnArr[index]

        for segbtn in btnArr {
            if btn.isEqual(segbtn) {
                segbtn.isSelected = true
            }else{
                segbtn.isSelected = false
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

protocol CustomSegmentDelegate {
    func segmentClicked(index: Int)
    
}
