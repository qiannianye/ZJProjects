//
//  ContentCell.swift
//  Cardqu
//
//  Created by qiannianye on 2017/11/15.
//  Copyright © 2017年 qiannianye. All rights reserved.
//

import UIKit

class ContentCell: UITableViewCell {

    var collectionView: UICollectionView?
    var parentController: UIViewController?
    var currentPage = 0
    
    var childControllers = [UIViewController](){
        didSet{
            collectionView?.reloadData()
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        childControllers = [UIViewController]()
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: screenWidth, height: screenHeight)
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets.zero
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight), collectionViewLayout: layout)
        collectionView?.dataSource = self
        collectionView?.delegate = self
        collectionView?.backgroundColor = UIColor.clear
        collectionView?.isPagingEnabled = true
        collectionView?.register(UICollectionViewCell.self , forCellWithReuseIdentifier: "UICollectionViewCellId")
        contentView.addSubview(collectionView!)
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

extension ContentCell:UICollectionViewDataSource,UICollectionViewDelegate,UIScrollViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childControllers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UICollectionViewCellId", for: indexPath)
        let vc = childControllers[indexPath.row]
        vc.view.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
        cell.contentView.addSubview(vc.view)
        self.parentController?.addChildViewController(vc)
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        currentPage = Int (scrollView.contentOffset.x/scrollView.frame.width)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "DidScroll"), object: nil, userInfo: ["scrollIndex":currentPage])
    }
}


