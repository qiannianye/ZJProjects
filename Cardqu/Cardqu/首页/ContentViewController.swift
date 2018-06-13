//
//  ContentViewController.swift
//  Cardqu
//
//  Created by qiannianye on 2018/3/29.
//  Copyright © 2018年 qiannianye. All rights reserved.
//

import UIKit
import ReactiveSwift

protocol ContentViewProtocol {
    var scrollProducer: AnyAPIProducer { get }
}

class ContentViewController: UIViewController,ContentViewProtocol {
    
    lazy var tableView: UITableView = {
        let table = UITableView(frame: view.bounds, style: .plain)
        table.separatorStyle = .none
        table.isScrollEnabled = false //默认不可滑动
        table.delegate = self
        table.dataSource = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.self.description())
        return table
    }()
    
    private(set) var scrollProducer = AnyAPIProducer.empty
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        scrollNotification()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ContentViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.self.description())
        return cell!
    }
}

extension ContentViewController: UITableViewDelegate{}

extension ContentViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var isCanScroll = true
        let offsetY = scrollView.contentOffset.y
        if offsetY <= 0 {
            isCanScroll = false
        }else{
            isCanScroll = true
        }
        
        print("child vc scroll[\(offsetY)]")
//        scrollProducer = AnyAPIProducer{(observer,_) in
//            observer.send(value: isCanScroll as Any)
//            observer.sendCompleted()
//        }
        
        tableView.isScrollEnabled = isCanScroll
        //发送通知
//        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ContainerScroll"), object: NSNumber(value: !isCanScroll), userInfo: nil)
        
    }
}

extension ContentViewController {
    func setupUI() {
        view.addSubview(tableView)
    }
    
    func scrollNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(setScroll), name: NSNotification.Name(rawValue: "SetScroll"), object: nil)
    }
    
    @objc func setScroll(notify: NSNotification) {
        
        let isCanScroll = notify.object as! NSNumber
        tableView.isScrollEnabled = isCanScroll.boolValue
    }
}
