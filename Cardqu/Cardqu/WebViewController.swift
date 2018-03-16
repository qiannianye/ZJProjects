//
//  WebViewController.swift
//  Cardqu
//
//  Created by qiannianye on 2018/3/7.
//  Copyright © 2018年 qiannianye. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {

    private var webUrl: String
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    init(title: String, webUrl: String) {
        self.webUrl = CQServiceEnvironment.test.host + webUrl
        super.init(nibName: nil, bundle: nil)
        self.title = title
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension WebViewController: UIWebViewDelegate{
    func setupUI() {
        let webView = UIWebView(frame: CGRect(x: 0, y: naviBarH, width: screenWidth, height: screenHeight - naviBarH))
        webView.delegate = self
        view.addSubview(webView)
        
        if self.webUrl.count > 0 && (self.webUrl.hasPrefix("https://") || self.webUrl.hasPrefix("http://")) {
            webView.loadRequest(URLRequest(url: URL(string: self.webUrl)!))
        }
    }
    
    func setupLeftItems(items: Array<AnyObject>) {
        var leftItems = [UIBarButtonItem]()
        for item in items {
            let btn = UIButton(type: .custom)
            btn.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
            
            if item.isKind(of: NSString.classForCoder()){//title-button
                btn.setTitle(item as? String, for: .normal)
            }else if item.isKind(of: UIImage.classForCoder()){
                btn.setImage(item as? UIImage, for: .normal)
            }
            
            btn.addTarget(self, action: #selector(leftItemClick), for: .touchUpInside)
            let barbuttonItem = UIBarButtonItem(customView: btn)
            leftItems.append(barbuttonItem)
        }
        navigationItem.leftBarButtonItems = leftItems
    }
    
    @objc func leftItemClick(){
        
    }
    
    //MARK - UIWebViewDelegate
    func webViewDidStartLoad(_ webView: UIWebView) {
        //
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        //
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        //
    }
}
