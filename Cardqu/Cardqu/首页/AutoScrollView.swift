//
//  AutoScrollView.swift
//  Cardqu
//
//  Created by qiannianye on 2017/11/8.
//  Copyright © 2017年 qiannianye. All rights reserved.
//

import UIKit

//MARK:自动滚动视图上的cell
class AutoScrollCell: UICollectionViewCell {
    var imgView: UIImageView?
    override init(frame: CGRect) {
        super.init(frame: frame)
        imgView = UIImageView(frame: frame)
        //imgView?.contentMode = UIViewContentMode.scaleAspectFit
        //图片大小自适应
        contentView.addSubview(imgView!)
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
    
    var images = [String](){
        didSet{
            collectionView?.reloadData()
            pageControl?.numberOfPages = images.count
            setupTimer()
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //滚动视图
    func setupSubViews(){
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: frame.size.width, height: frame.size.height)
        layout.minimumInteritemSpacing = 0.0
        layout.minimumLineSpacing = 0.0
        layout.scrollDirection = UICollectionViewScrollDirection.horizontal
        
        collectionView = UICollectionView(frame: bounds, collectionViewLayout: layout)
        collectionView?.backgroundColor = UIColor.yellow
        collectionView?.isPagingEnabled = true
        collectionView?.bounces = false
        collectionView?.dataSource = self
        collectionView?.delegate = (self as UICollectionViewDelegate)
        collectionView?.register(AutoScrollCell.self, forCellWithReuseIdentifier: cellReuseIdentifier)
        addSubview(collectionView!)
        
        setupPageControl()
    }
    
    func setupPageControl() {
        pageControl = UIPageControl(frame: CGRect(x: 0, y: frame.size.height - 15, width: frame.size.width, height: 15))
        pageControl?.currentPage = 0
        pageControl?.numberOfPages = images.count
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


extension AutoScrollView:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    //每个分区item的个数
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    //cell
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as? AutoScrollCell
        
        //填充视图
        let imageUrl = images[indexPath.row]
        
        print(imageUrl,":",indexPath.row)
        
       
        return cell!
    }
    
    //itemSize
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.size.width, height: frame.size.height)
    }
    
    //section边距
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    //选中cell
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension AutoScrollView:UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentIndex = Int(scrollView.contentOffset.x/scrollView.frame.size.width)
        pageControl?.currentPage = currentIndex
    }
}
