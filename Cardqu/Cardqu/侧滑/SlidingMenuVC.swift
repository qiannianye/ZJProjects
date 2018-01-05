//
//  SlidingMenuVC.swift
//  Cardqu
//
//  Created by qiannianye on 2017/11/6.
//  Copyright © 2017年 qiannianye. All rights reserved.
//

import UIKit

class SlidingMenuVC: UIViewController {

    var mainVC : UIViewController?
    var leftVC : UIViewController?
    var leftGap: CGFloat = 300.0 //
    
    init(mainVC :UIViewController, leftVC :UIViewController, gapWidth :CGFloat) {
        super.init(nibName: nil, bundle: nil)
        self.mainVC = mainVC
        self.leftVC = leftVC
        self.leftGap = gapWidth
        
        self.view.addSubview(leftVC.view)
        self.view.addSubview(mainVC.view)
    
        self.addChildViewController(leftVC)
        self.addChildViewController(mainVC)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("an error")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //初始化,让左边视图先偏移到左边的位置
        self.leftVC?.view.transform = CGAffineTransform(translationX: -self.leftGap, y: 0)
        
        //添加手势
        for viewController in (mainVC?.childViewControllers)! {
            self.addPanGesture(view: viewController.view)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //添加手势
    func addPanGesture(view :UIView) {
        let pan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(edgePanGesture(_:)))
        pan.edges = UIRectEdge.left
        view.addGestureRecognizer(pan)
        
        //不使用边缘手势
//        let pan = UIPanGestureRecognizer(target: self, action: #selector(edgePanGesture(_:)))
//        let gestureView = UIView(frame:CGRect(x: 0, y: 0, width: 44, height: screenHeight))
//        gestureView.addGestureRecognizer(pan)
//        view.addSubview(gestureView)
    }
    
    @objc private func edgePanGesture(_ pan :UIScreenEdgePanGestureRecognizer){
        
        let offsetX = pan.translation(in: pan.view).x
        print(offsetX)
        
        if (pan.state == UIGestureRecognizerState.changed && offsetX <= leftGap) {
            mainVC?.view.transform = CGAffineTransform(translationX:max(offsetX, 0),y: 0)
            leftVC?.view.transform = CGAffineTransform(translationX: max(-leftGap + offsetX, 0), y: 0)
        } else if (pan.state == UIGestureRecognizerState.cancelled || pan.state == UIGestureRecognizerState.failed || pan.state == UIGestureRecognizerState.ended) {
            if offsetX > (screenWidth * 0.5){
                self.openLeftMenue(offsetX: offsetX)
            }else{
                self.closeLeftMenu(offsetX: offsetX)
            }
        }
    }
    
    //打开
    func openLeftMenue(offsetX : CGFloat) {
        UIView.animate(withDuration: 0.25, animations: {
            self.mainVC?.view.transform = CGAffineTransform(translationX: self.leftGap, y: 0)
            self.leftVC?.view.transform = CGAffineTransform.identity //最初状态:在主视图view上无偏移.
        }) { (finish : Bool) in
            //在主视图上添加btn,用于将展开的视图关闭.因为边缘手势的点击事件已经不响应了.
            if finish {
                self.mainVC?.view.addSubview(self.coverBtn)
            }
        }
    }
    
    //关闭
    @objc func closeLeftMenu(offsetX : CGFloat) {
        UIView.animate(withDuration: 0.25, animations: {
            self.leftVC?.view.transform = CGAffineTransform(translationX: -self.leftGap, y: 0)
            self.mainVC?.view.transform = CGAffineTransform.identity //回到最初状态
        }) { (finish : Bool) in
            if finish{
                self.coverBtn.removeFromSuperview()
            }
        }
    }
    
    @objc private func panCloseLeftMenu(_ panGesture: UIPanGestureRecognizer){
        let offsetX = panGesture.translation(in: self.mainVC?.view).x
        
        print(offsetX)
        
        if offsetX > 0 {
            return
        }
        
        if panGesture.state == UIGestureRecognizerState.changed && offsetX > -leftGap {
            self.mainVC?.view.transform = CGAffineTransform(translationX: offsetX + leftGap, y: 0)
            self.leftVC?.view.transform = CGAffineTransform(translationX:  offsetX, y: 0)
        }else if panGesture.state == UIGestureRecognizerState.ended || panGesture.state == UIGestureRecognizerState.cancelled || panGesture.state == UIGestureRecognizerState.failed{
            if offsetX > -screenWidth * 0.5{
                self.openLeftMenue(offsetX: offsetX)
            }else {
                self.closeLeftMenu(offsetX: offsetX)
            }
        }
    }
    
    private lazy var coverBtn: UIButton = {

        let btn = UIButton(frame: (self.mainVC?.view.bounds)!)
        btn.backgroundColor = UIColor.init(white: 0, alpha: 0.4)
        btn.addTarget(self, action: #selector(closeLeftMenu), for: .touchUpInside)
        btn.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(panCloseLeftMenu(_:))))

        return btn

    }()
}
