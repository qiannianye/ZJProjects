//
//  CustomFlowLayout.swift
//  CircleScrollDemo
//
//  Created by qiannianye on 2018/3/28.
//  Copyright © 2018年 qiannianye. All rights reserved.
//

import UIKit

class CustomFlowLayout: UICollectionViewFlowLayout {

    private var previousOffsetX: CGFloat = 0
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CustomFlowLayout {
    
    override func prepare() {
        super.prepare()
        scrollDirection = .horizontal
        sectionInset = UIEdgeInsets.zero

        itemSize = CGSize(width: (collectionView?.frame.width)!, height: (collectionView?.frame.height)!)
        minimumLineSpacing = 0
    }
    
    /**
     数组中保存的是 UICollectionViewLayoutAttributes *attrs;
     1.一个cell对应一个UICollectionViewLayoutAttributes对象
     2.UICollectionViewLayoutAttributes对象决定了cell的frame
     */
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        let attributes = super.layoutAttributesForElements(in: rect)
        guard let arr = attributes else { return nil }
        
        let offsetX = (collectionView?.contentOffset.x)!
        let width = (collectionView?.frame.width)!
//        let scrollCenterX = offsetX + width * 0.5
//        print("collectioncenterx: [\(scrollCenterX)]")
//        print("collectionview offset x: [\((collectionView?.contentOffset.x)!)]")
        
        let currIndex = Int(offsetX / width)
        let cellAttri = layoutAttributesForItem(at: IndexPath(item: currIndex, section: 0))
        
        
        //let scale = (offsetX - CGFloat(currIndex) * width)/width
        for attri in arr {
            var frame = attri.frame
            if cellAttri?.indexPath.item == attri.indexPath.item{
                frame.origin.x += 20.0
                frame.origin.y = 0
                frame.size.width -= 40.0
                frame.size.height = (collectionView?.frame.height)!
            }else{
                frame.origin.x -= 10.0
                frame.origin.y += 5.0
                frame.size.width += 20.0
                frame.size.height -= 10.0
            }
            
            UIView.animate(withDuration: 0.25, animations: {
                attri.frame = frame
            })
            
            
//            let scale = 1 - abs(attri.center.x - scrollCenterX)/(collectionView?.frame.width)!
//            attri.transform = CGAffineTransform(scaleX: scale, y: scale)
//            print("attri center x:[\(attri.center.x)]")
        }
        return arr
    }
    
    /**
     * 当collectionView的显示范围发生改变的时候，是否需要重新刷新布局
     * 一旦重新刷新布局，就会重新调用下面的方法：（也就上面那两）
     1.prepareLayout
     2.layoutAttributesForElementsInRect:方法
     */
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
//    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
//
//        // 分页以1/4处
//        var diff: CGFloat = 3
////        if minimumLineSpacing == 10 {
////            diff = 4.0
////        }
//        if (proposedContentOffset.x > previousOffsetX + self.itemSize.width / diff) {
//            previousOffsetX += (collectionView?.frame.width)! - self.minimumLineSpacing * (diff - 1);
//        } else if (proposedContentOffset.x < previousOffsetX  - self.itemSize.width / diff) {
//           previousOffsetX -= (collectionView?.frame.width)! - self.minimumLineSpacing * (diff - 1);
//        }
//
//        return CGPoint(x: previousOffsetX,y: proposedContentOffset.y);
//    }
}

