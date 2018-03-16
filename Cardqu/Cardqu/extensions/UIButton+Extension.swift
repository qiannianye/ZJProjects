//
//  UIButton+Extension.swift
//  Cardqu
//
//  Created by qiannianye on 2017/12/18.
//  Copyright © 2017年 qiannianye. All rights reserved.
//

import Foundation
import UIKit
import ReactiveCocoa
import ReactiveSwift

private var indexKey = "IndexKey"

extension UIButton{
    var index: Int {
        get {
            return (objc_getAssociatedObject(self, &indexKey) as? Int)!
        }
        set(newValue) {
            objc_setAssociatedObject(self, &indexKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
}

extension Reactive where Base: UIButton {
    public var isEnabled: BindingTarget<Bool> {
        return makeBindingTarget({
            $0.isEnabled = $1
        })
    }
}

