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

protocol BaseViewModelProtocol {
    var dataArr: [AnyObject] { get }
    var fetchAction: AnyAPIAction { get }
}

class BaseViewModel: BaseViewModelProtocol {
    
    private(set) var dataArr: [AnyObject] = []
    
    private(set) lazy var fetchAction: AnyAPIAction = AnyAPIAction { [unowned self] _ -> AnyAPIProducer in
        
        return self.fetchSignal().on(value:{ (value) in
            self.dataArr.append(contentsOf: value as! [AnyObject])
        })
    }
    
    func fetchSignal() -> AnyAPIProducer {
        return AnyAPIProducer.empty
    }
}

