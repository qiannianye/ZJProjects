//
//  AutoScrollView.swift
//  Cardqu
//
//  Created by qiannianye on 2017/11/8.
//  Copyright © 2017年 qiannianye. All rights reserved.
//

import UIKit
import Kingfisher

//MARK:自动滚动视图上的cell
class AutoScrollCell: UICollectionViewCell {
    var imgView = UIImageView()
    var imgUrl: String? {
        didSet{
            guard let url = imgUrl else { return }

            imgView.kf.setImage(with: ImageResource(downloadURL: URL(string: url)!), placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        imgView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        imgView.contentMode = UIViewContentMode.scaleAspectFit
        contentView.addSubview(imgView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK:自动滚动视图
class AutoScrollView: UIView {
    var collectionView: UICollectionView?
    var scrollTimer: Timer?
    let cellReuseIdentifier = "CollectionViewCellId"
    var pageControl: UIPageControl?
    
    var images = [AnyObject](){
        
        didSet{
            guard images.count > 0 else { return }
            
            pageControl?.numberOfPages = images.count
            collectionView?.reloadData()
            //setupTimer()
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension AutoScrollView: UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count + 2
    }
    
    //cell
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as? AutoScrollCell
        
        //填充视图
        if indexPath.row == 0 {
            let model = images.last as? AdModel
            cell?.imgUrl = model?.image_url
        }else if indexPath.row == (images.count + 1){
            let model = images.first as? AdModel
            cell?.imgUrl = model?.image_url
        }else{
            let model = images[indexPath.row - 1] as? AdModel
            cell?.imgUrl = model?.image_url
        }
        return cell!
    }
    
    //选中cell
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension AutoScrollView: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var currentIndex = Int(scrollView.contentOffset.x/scrollView.frame.size.width)
        
        if currentIndex == (images.count + 1) || currentIndex == 0 {
            if currentIndex == (images.count + 1){
                currentIndex = 1
            }else if currentIndex == 0{
                currentIndex = images.count
            }
            
            collectionView?.selectItem(at: IndexPath(item: currentIndex, section: 0), animated: false, scrollPosition: .centeredHorizontally)
        }
        pageControl?.currentPage = currentIndex - 1
    }
}

extension AutoScrollView {
    func setupUI() {
        setupCollectionView()
        setupPageControl()
    }
    
    func setupCollectionView(){
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: frame.width, height: frame.height)
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        layout.minimumInteritemSpacing = 0.0
        layout.minimumLineSpacing = 0.0
        layout.scrollDirection = UICollectionViewScrollDirection.horizontal
        
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height), collectionViewLayout: layout)
        collectionView?.backgroundColor = UIColor.yellow
        collectionView?.isPagingEnabled = true
        collectionView?.bounces = false
        collectionView?.dataSource = self
        collectionView?.delegate = (self as UICollectionViewDelegate)
        collectionView?.register(AutoScrollCell.self, forCellWithReuseIdentifier: cellReuseIdentifier)
        addSubview(collectionView!)
        
        collectionView?.scrollToItem(at: IndexPath(item: 1, section: 0), at: .centeredHorizontally, animated: false)
    }
    
    func setupPageControl() {
        pageControl = UIPageControl(frame: CGRect(x: 0, y: frame.size.height - 15, width: frame.size.width, height: 15))
        pageControl?.currentPageIndicatorTintColor = UIColor.red
        pageControl?.pageIndicatorTintColor = UIColor.gray
        pageControl?.currentPage = 0
        addSubview(pageControl!)
    }
    
    //定时器
    func setupTimer() {
        scrollTimer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(timerResponds), userInfo: nil, repeats: true)
        RunLoop.main.add(scrollTimer!, forMode: RunLoopMode.commonModes)
    }
    
    @objc func timerResponds(){
        let currentIndex = Int((collectionView?.contentOffset.x)!/frame.size.width)
        var scrollIndex = currentIndex + 1
        
        if scrollIndex >= images.count {//滑动到最后
            scrollIndex = 0
        }
        
        collectionView?.scrollToItem(at: IndexPath(row:scrollIndex,section:0), at:.left, animated: true)
    }
}
