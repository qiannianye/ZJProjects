//
//  BaseViewModel.swift
//  Cardqu
//
//  Created by qiannianye on 2017/12/22.
//  Copyright © 2017年 qiannianye. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift

class BaseViewModel: NSObject {
    var title: String?
    var disposeBag = Bag<Disposable>()
    override init() {
        super.init()
        self.initReactive()
    }
    
    func initReactive() {
        
    }
}
