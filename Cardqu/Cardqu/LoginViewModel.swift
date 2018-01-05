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

class LoginViewModel: BaseViewModel {
    //用户名
    var userName: String?
    var password: String?
    var isValidUserName: Bool = true
    var isValidPassword = true
    
    func addCheckObserver() {
        isValidUserName = ((self.userName?.lengthOfBytes(using: .utf8)) != nil)
        isValidPassword = ((self.password?.lengthOfBytes(using: .utf8)) != nil)
        let (signal1, observer1) = Signal<Bool, NoError>.pipe()
        signal1.observe(observer1)
        
    }
}
