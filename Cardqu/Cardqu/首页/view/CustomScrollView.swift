//
//  CustomScrollView.swift
//  CircleScrollDemo
//
//  Created by qiannianye on 2018/3/27.
//  Copyright © 2018年 qiannianye. All rights reserved.
//

import UIKit

/*
 *可复用的ScrollView,UIImageView可复用
 */

enum ImageShowStyle {
    case normal    //正常
    case scaling   //按比例缩放
}

enum ScrollStyle {
    case notCircle   //正常滚动,不循环
    case circle      //手动循环
    case autoCircle  //自动循环
}

class CustomScrollView: UIView {
    var isAutoScroll: Bool = false  //当有定时器自动滑动时,又手动滑动,需将定时器关闭,避免手动滑动停止时定时器还在自动滑动,造成页面滑动太过迅速,体验不好.
    var scrollPatterns = ScrollStyle.notCircle //默认正常
    var imageStyle = ImageShowStyle.normal //默认正常
    var images = [String]() {
        didSet {//初始化不会走didSet方法.
            guard images.count > 0 else { return }
            pageControl.numberOfPages = images.count
            collectVw.reloadData()
            setupTimer()
        }
    }
 
    var collectVw: UICollectionView!
    var pageControl: UIPageControl!
    var timer: Timer?
    
    init(frame: CGRect, scroll:ScrollStyle = ScrollStyle.notCircle, imgStyle: ImageShowStyle = ImageShowStyle.normal) {
        super.init(frame: frame)
        self.scrollPatterns = scroll
        self.imageStyle = imgStyle
        self.setupUI()
        self.config()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CustomScrollView: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if scrollPatterns == .notCircle {
            return images.count
        }
        return images.count + 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:ImageCollectionCell.self.description() , for: indexPath) as! ImageCollectionCell
        if scrollPatterns == .notCircle {
            cell.imgUrl = images[indexPath.row]
        }else{
            if indexPath.row == 0{
                cell.imgUrl = images.last
            }else if indexPath.row == (images.count + 1){
                cell.imgUrl = images.first
            }else{
                cell.imgUrl = images[indexPath.row - 1]
            }
        }
        return cell
    }
}

extension CustomScrollView: UICollectionViewDelegate{
    
}

extension CustomScrollView: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        //print("didScroll[\(scrollView.contentOffset.x)]")
        
        if scrollPatterns == .notCircle {
            let currentIndex = Int(scrollView.contentOffset.x/scrollView.frame.width)
            pageControl.currentPage = currentIndex
            return
        }
        circleScroll()
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        print("willbegindragging[\(scrollView.contentOffset.x)]")
        timer?.fireDate = NSDate.distantFuture
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        timer?.fireDate = NSDate.distantPast
    }
}

extension CustomScrollView {
    
    func autoCircleScroll(){
        let currIndex = scrollCurrent()
        if scrollPatterns == .autoCircle && timer != nil {
            collectVw?.setContentOffset(CGPoint(x: CGFloat(currIndex + 1) * frame.width, y: 0), animated: true)
            pageControl.currentPage = currIndex + 1
        }
    }
    
    func circleScroll() {
        let currIndex = scrollCurrent()
        pageControl.currentPage = currIndex - 1
    }
    
    private func scrollCurrent() -> Int {
        
        var currentIndex = Int(collectVw.contentOffset.x/collectVw.frame.width)
        
        if currentIndex == (images.count + 1){
            currentIndex = 1
            collectVw?.setContentOffset(CGPoint(x: CGFloat(currentIndex) * frame.width, y: 0), animated: false)
        }
        
        if currentIndex == 0 {
            currentIndex = images.count
            if collectVw.contentOffset.x <= 0.0{
                collectVw?.setContentOffset(CGPoint(x: CGFloat(currentIndex) * frame.width, y: 0), animated: false)
            }
        }
        return currentIndex
    }
    
    func config() {
        if scrollPatterns == .notCircle { return }
        collectVw?.scrollToItem(at: IndexPath(item: 1, section: 0), at: .centeredHorizontally, animated: false)
    }
    
    func setupUI() {
        setupCollectionView()
        setupPageControl()
    }
    
    private func setupLayout() -> UICollectionViewFlowLayout {
        if imageStyle == .normal {
            let layout = UICollectionViewFlowLayout()
            layout.itemSize = CGSize(width: frame.width, height: frame.height)
            layout.sectionInset = UIEdgeInsets.zero
            layout.minimumInteritemSpacing = 0.0
            layout.minimumLineSpacing = 0.0
            layout.scrollDirection = .horizontal
            
            return layout
        }
        
        let layout = CustomFlowLayout()
        return layout
    }
    
    func setupCollectionView(){
        collectVw = UICollectionView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height), collectionViewLayout: setupLayout())
        collectVw?.backgroundColor = UIColor.yellow
        collectVw?.isPagingEnabled = true
        collectVw?.bounces = false
        collectVw?.dataSource = self
        collectVw?.delegate = self
        addSubview(collectVw!)
        
        collectVw?.register(ImageCollectionCell.self, forCellWithReuseIdentifier: ImageCollectionCell.self.description())
    }
    
    func setupPageControl() {
        pageControl = UIPageControl(frame: CGRect(x: 0, y: frame.size.height - 45, width: frame.size.width, height: 15))
        pageControl?.currentPageIndicatorTintColor = UIColor.red
        pageControl?.pageIndicatorTintColor = UIColor.gray
        pageControl?.currentPage = 0
        addSubview(pageControl!)
    }
    
    func setupTimer() {
        if scrollPatterns == .autoCircle {
            timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(timerResponds), userInfo: nil, repeats: true)
        }
    }
    
    @objc private func timerResponds (){
        autoCircleScroll()
    }
}
