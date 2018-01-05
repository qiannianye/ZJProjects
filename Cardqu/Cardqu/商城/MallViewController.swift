//
//  MallViewController.swift
//  Cardqu
//
//  Created by qiannianye on 2017/11/16.
//  Copyright © 2017年 qiannianye. All rights reserved.
//

import UIKit

class MallViewController: UIViewController {

    var collectionView: UICollectionView?
    var dataArr = [["11","12","13"],["22","23"],["33","34","35"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        //let itemWidth = (screenWidth - 30)/2
        let layout = UICollectionViewFlowLayout()
        //layout.itemSize = CGSize(width: itemWidth, height: itemWidth*2/3)
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 5
        layout.headerReferenceSize = CGSize(width: screenWidth, height: 44)
        
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight), collectionViewLayout: layout)
        collectionView?.dataSource = self
        collectionView?.delegate = self
        collectionView?.backgroundColor = UIColor.clear
        collectionView?.register(GoodsShowCell.self , forCellWithReuseIdentifier: "GoodsShowCellId")
        collectionView?.register(GoodsHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "GoodsHeaderViewId")
        view.addSubview(collectionView!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension MallViewController:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let arr = dataArr[section]
        return arr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GoodsShowCellId", for: indexPath) as? GoodsShowCell
        cell?.updateGoodsShowCell(imgUrl: "http://kaquftp.b0.upaiyun.com/groups/banner_105058.jpg", price: "56.0")
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        var header: GoodsHeaderView?
        if kind.elementsEqual(UICollectionElementKindSectionHeader) {
            header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "GoodsHeaderViewId", for: indexPath) as? GoodsHeaderView
            header?.updateGoodsHeader(title: "hahaha")
        }
        return header!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let arr = dataArr[indexPath.section]
        let itemSize = CGSize(width: (screenWidth - 30)/2, height: (screenWidth - 30)/2*2/3)
        
        if arr.count % 2 == 0 {
            return itemSize
        }else{
            if (indexPath.row != arr.count-1){
                return itemSize
            }
            return CGSize(width: screenWidth - 20, height: 88)
        }
    }
}

