//
//  LoginViewController.swift
//  Cardqu
//
//  Created by qiannianye on 2017/12/14.
//  Copyright © 2017年 qiannianye. All rights reserved.
//

import UIKit
import SnapKit
import ReactiveCocoa
import ReactiveSwift
import Result

class LoginViewController: UIViewController {

    let thirdpartyHeight: CGFloat = 100
    var userNameTF: UITextField!
    var passwordTF: UITextField!
    var loginBtn: UIButton?
    
    //private var loginViewModel = LoginViewModel()
    private var loginViewModel: LoginViewModelProtocol! {
        didSet{
            loginViewModel.setupInput(accountSignal: userNameTF.reactive.continuousTextValues, passwordSignal: passwordTF.reactive.continuousTextValues)
            userNameTF.reactive.text <~ loginViewModel.account
            passwordTF.reactive.text <~ loginViewModel.password
            
            loginBtn?.reactive.pressed = CocoaAction(loginViewModel.loginAction, input: loginBtn)
            loginViewModel.loginAction.values.observeValues { [unowned self] (value) in
                
                //print("login in ![\(value)]" )
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    lazy var bgImageView: UIImageView = {
        let imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight - thirdpartyHeight ))
        imgView.image = UIImage(named: "kq_login_bgImage.jpg")
        imgView.isUserInteractionEnabled = true
        return imgView
    }()
    
    lazy var logoView: UIView = {
        let logoBgView = UIView(frame: CGRect(x: 0, y: naviBarH, width: screenWidth , height: 150))
        return logoBgView
    }()
    
    lazy var scrollView: UIScrollView = {
        let sv = UIScrollView(frame: CGRect(x: 0, y: logoView.frame.maxY, width: screenWidth, height: screenHeight - logoView.frame.height - naviBarH - thirdpartyHeight))
        
        //问题:为scrollView上的直接子视图添加约束,即使设置了contentSize也不管用.
        //sv.contentSize = CGSize(width: screenWidth, height: sv.frame.height)
        return sv
    }()
    
    private func textField(_ placeholder: String?) -> UITextField {
        let tf = UITextField()
        tf.placeholder = placeholder
        tf.textColor = UIColor.black
        tf.font = UIFont.systemFont(ofSize: 12)
        tf.clearButtonMode = UITextFieldViewMode.whileEditing
        tf.backgroundColor = UIColor.yellow
        //tf.becomeFirstResponder()
        return tf
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        loginViewModel = LoginViewModel()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension LoginViewController{
    
    @objc func dismissVC(){
        self.dismiss(animated: true, completion: nil)
    }
    
    func setupUI() {
        view.backgroundColor = UIColor.white
        view.addSubview(bgImageView)
        bgImageView.addSubview(logoView)
        bgImageView.addSubview(scrollView)
        setupApplogo()
        setupTextFields()
        setupLoginButton()
        setupThirdparty()
        view.setNeedsUpdateConstraints()
        
        let disBtn = UIButton(type: .system)
        disBtn.frame = CGRect(x: screenWidth - 64, y: statusBarH, width: 44, height: 44)
        disBtn.setTitle("dismiss", for: .normal)
        disBtn.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        view.addSubview(disBtn)
    }
    
    func setupApplogo() {
        let logoImg = UIImageView(frame: CGRect(x: (logoView.frame.width - 80)/2, y: 0, width: 80, height: 60))
        logoImg.image = UIImage(named: "kqAppName_icon")
        logoView.addSubview(logoImg)
        
        let appName = UILabel(frame: CGRect(x: 12, y: logoImg.frame.maxY, width: screenWidth - 24, height: 20))
        appName.text = "Card Qu"
        appName.textAlignment = .center
        appName.font = UIFont.boldSystemFont(ofSize: 16)
        appName.textColor = UIColor.white
        logoView.addSubview(appName)
    }
    
    func setupTextFields() {
        userNameTF = textField("")
        passwordTF = textField("请输入密码")
        scrollView.addSubview(userNameTF!)
        scrollView.addSubview(passwordTF!)
    }
    
    func setupLoginButton() {
        loginBtn = UIButton(type: .custom)
        loginBtn?.setBackgroundImage(UIColor.gray.image, for: .disabled)
        loginBtn?.setBackgroundImage(UIColor.orange.image, for: .normal)
        loginBtn?.clipsToBounds = true
        loginBtn?.layer.cornerRadius = 4
        loginBtn?.setTitle("login", for: .normal)
        loginBtn?.setTitleColor( .white, for: .normal)
        scrollView.addSubview(loginBtn!)
    }

    func setupThirdparty() {
        let arr = ["QQ","Weixin","Weibo"]
        let itemWidth = screenWidth / CGFloat(arr.count)
        let itemHeight: CGFloat = 50
        var itemOriginX: CGFloat = 0
        var i = 0
        
        for platform in arr {
            
            let bgView = UIView(frame: CGRect(x: itemOriginX, y:scrollView.frame.maxY + (thirdpartyHeight - itemHeight)/2, width: itemWidth, height: itemHeight))
            view.addSubview(bgView)
            itemOriginX = bgView.frame.maxX
            
            let iconImg = UIImageView(frame: CGRect(x: (bgView.frame.width - 30)/2, y: 0, width: 30, height: 30))
            iconImg.image = UIImage(named: "")
            bgView.addSubview(iconImg)
            
            let platformLb = UILabel(frame: CGRect(x: 0, y: iconImg.frame.maxY + 8, width: bgView.frame.width, height: 12))
            platformLb.text = platform
            platformLb.textAlignment = .center
            platformLb.font = UIFont.systemFont(ofSize: 12)
            bgView.addSubview(platformLb)
        
            let btn = UIButton(type: .custom)
            btn.frame = CGRect(x: 0, y: 0, width: bgView.frame.width, height: bgView.frame.height)
            btn.addTarget(self, action: #selector(respondsToThirdLogin(btn:)), for: .touchUpInside)
            bgView.addSubview(btn)
            
            //btn.index = i
            btn.tag = i
            i += 1
            //print("btn index = \(btn.index)")
        }
    }
    
    

    //MARK:按钮点击事件
    
    //第三方登录
    @objc func respondsToThirdLogin(btn: UIButton) {
        switch btn.tag {
        case 0:
            print("qq login")
        case 1:
            do {
               print("weixin login")
               ThirdShare.share.wxAuthorization(controller: self)
            }
        default:
            break
        }
    }
    
    //MARK:控件约束
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        //问题:scrollView上的直接子视图,如果只设置上下左右约束,不给宽高,就会出现问题.因为scrollView的frame虽然是设置的是屏宽屏高或者自己理想的值,但是它的contentSize没有那么大,没有撑起来.所以依赖于它的子视图的位置就会受影响.
        //解决:1.可以直接在scrollView上先添加一个containerView,把它的宽高先撑起来.再把其他的子视图贴在这个containerView上,再设置约束.
        //2. 可以直接设置宽高约束,不设置依赖右边或者下边.
        userNameTF?.snp.makeConstraints { (make) in
            make.top.equalTo(60)
            make.left.equalTo(12)
            //make.right.equalTo(-12)
            make.height.equalTo(24)
            make.width.equalTo(screenWidth - 24)
        }
        
        passwordTF?.snp.makeConstraints { (make) in
            make.top.equalTo((userNameTF?.snp.bottom)!).offset(10)
            make.left.equalTo((userNameTF?.snp.left)!)
            make.right.equalTo((userNameTF?.snp.right)!)
            make.height.equalTo((userNameTF?.snp.height)!)
        }
        
        loginBtn?.snp.makeConstraints({ (make) in
            make.top.equalTo((passwordTF?.snp.bottom)!).offset(10)
            make.left.equalTo((passwordTF?.snp.left)!)
            make.right.equalTo((passwordTF?.snp.right)!)
        })
    }
}
