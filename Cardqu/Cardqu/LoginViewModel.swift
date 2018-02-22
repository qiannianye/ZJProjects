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
            print("username is valid?[\(username.isValidPhoneNum)]")
            return username
        })
        
        password <~ passwordSignal.map({ (text) -> String in
            return text ?? ""
        })
    }
    
    //
    private var loginSignalProducer: SignalProducer<Any?,NoError> {

        return UserAPI().mobileLogin(userName: self.account.value, password: self.password.value, type: "general", clientId: "IOS_" + AppInfo.appVersion, appId: "").on(value:{ value in
            //print("value is [\(String(describing: value))]")
            let model = UserModel.deserialize(from: (value as! Dictionary))
            print("user's name is \(String(describing: model?.display_name))")
        })
    }
    
    private var loginProperty: Property<Bool> {
        return Property.combineLatest(account,password).map({(username, password) -> Bool in
            return  username.count > 0 && password.count > 0 && username.isValidPhoneNum && !(password.isEqualTo(""))
        })
    }
}
