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
        }
    }
    
    lazy var bgImageView: UIImageView = {
        let imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight - thirdpartyHeight ))
        imgView.image = UIImage(named: "kq_login_bgImage.jpg")
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
    
    lazy var textField = {(placeholder: String?) -> UITextField in
        let tf = UITextField()
        tf.placeholder = placeholder
        tf.textColor = UIColor.white
        tf.font = UIFont.systemFont(ofSize: 12)
        tf.clearButtonMode = UITextFieldViewMode.whileEditing
        tf.backgroundColor = UIColor.yellow
        return tf
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        createLoginSignal()
        loginViewModel.setupInput(accountSignal: userNameTF.reactive.continuousTextValues, passwordSignal: passwordTF.reactive.continuousTextValues)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension LoginViewController{
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
        userNameTF = textField("请输入手机号")
        passwordTF = textField("请输入密码")
        scrollView.addSubview(userNameTF!)
        scrollView.addSubview(passwordTF!)
    }
    
    func setupLoginButton() {
        loginBtn = UIButton(type: .custom)
        loginBtn?.backgroundColor = UIColor.orange
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
            
            btn.index = i
            i += 1
            print("btn index = \(btn.index)")
        }
    }
    
    //MARK:创建信号
    //登录按钮信号
    private func createLoginSignal() {

        let nameSignal = userNameTF?.reactive.continuousTextValues.map{(text) in
            return text != nil ? true : false
        }
        
        let pwdSignal = passwordTF?.reactive.continuousTextValues.map{(text) in
            return text != nil ? true : false
        }
        
        let checkAccountSignal = Signal.combineLatest(nameSignal!, pwdSignal!).map({
            return $0 && $1
        })
        
        let loginProperty = Property(initial: false, then: checkAccountSignal)
        let loginAction = Action<(String, String), AnyObject, NoError>(enabledIf: loginProperty) { (name, pwd) -> SignalProducer<AnyObject, NoError> in
            self.createLoginSignalProducer(username: name, password: pwd)
        }
        
        loginAction.values.observeValues { (respondsData) in
            
        }
        
        loginBtn?.reactive.pressed = CocoaAction<UIButton>(loginAction, { _ in
            ((self.userNameTF?.text)!,(self.passwordTF?.text)!)
        })
    }
    
    //创建登录信号创作并登录
    private func createLoginSignalProducer(username: String, password: String) -> SignalProducer<AnyObject, NoError>{
        let (l_signal, l_observer) = Signal<AnyObject, NoError>.pipe()
        let l_signal_producer = SignalProducer<AnyObject, NoError>(l_signal)
        let dto = LoginDTO()
        dto.mobileLoginParameters(userName: username, password: password, type: "mobile", clientId: "IOS", appId: "")
        requestApi.startRequestSuccess(successBlock: { (respondsData) in
            l_observer.send(value: respondsData)
            l_observer.sendCompleted()
            print("login data:\(respondsData)")
        }) { (error) in
            //
        }
        return l_signal_producer
    }
    
    
    //MARK:按钮点击事件
    
    //第三方登录
    @objc func respondsToThirdLogin(btn: UIButton) {
        switch btn.index {
        case 0: break

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
