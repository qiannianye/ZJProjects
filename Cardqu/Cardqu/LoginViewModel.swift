//
//  LoginViewModel.swift
//  Cardqu
//
//  Created by qiannianye on 2017/12/22.
//  Copyright © 2017年 qiannianye. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift
import Result

//MARK:interface
protocol LoginViewModelProtocol {
    func setupInput(accountSignal: Signal<String?,NoError>, passwordSignal: Signal<String?,NoError>)
    
    var account: MutableProperty<String> { get }
    var password: MutableProperty<String> { get }
    var loginAction: Action<Any?,Any?,NoError> { get }
}

extension LoginViewModel: LoginViewModelProtocol {}

class LoginViewModel: BaseViewModel {

    private(set) var account = MutableProperty("")
    private(set) var password = MutableProperty("")
    
    private(set) lazy var loginAction: Action<Any?,Any?,NoError> = Action<Any?,Any?,NoError>(enabledIf: self.loginProperty) { [unowned self] _ -> SignalProducer<Any?, NoError> in
        self.loginSignalProducer
    }
    
    func setupInput(accountSignal: Signal<String?, NoError>, passwordSignal: Signal<String?, NoError>) {
        
        account <~ accountSignal.map({ (text) -> String in
            let username = (text ?? "").substringTo(11)
            //return (username.isValidPhoneNum ? username : "请输入有效的手机号")
            print("username is valid?[\(username.isValidPhoneNum)]")
            return username
        })
        
        password <~ passwordSignal.map({ (text) -> String in
            //这里需要做加密
            let despwd = (text ?? "").encrypt(key: encryptKey)
            return despwd
        })
    }
    
    //
    private var loginSignalProducer: SignalProducer<Any?,NoError> {
        
        return LoginAPI().mobileLogin(userName: self.account.value, password: self.password.value, type: "mobile", clientId: "IOS", appId: "").on(value:{ value in
            print("value is [\(value)]")
        })
    }
    
    private var loginProperty: Property<Bool> {
        return Property.combineLatest(account,password).map({(username, password) -> Bool in
            return  username.count > 0 && password.count > 0 && username.isValidPhoneNum && !(password.isEqualTo(""))
        })
    }
}
