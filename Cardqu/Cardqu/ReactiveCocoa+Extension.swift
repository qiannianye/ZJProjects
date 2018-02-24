//
//  ReactiveCocoa+Extension.swift
//  Cardqu
//
//  Created by qiannianye on 2018/2/24.
//  Copyright © 2018年 qiannianye. All rights reserved.
//

import Foundation

import ReactiveCocoa
import ReactiveSwift
import Result

typealias NSignal<T> = ReactiveSwift.Signal<T,NoError>
typealias AnySignal = Signal<Any?,NoError>
typealias APISignal<T> = Signal<T,APIError>
typealias AnyAPISignal = Signal<Any?,APIError>

typealias NProducer<T> = SignalProducer<T,NoError>
typealias AnyProducer = SignalProducer<Any?,NoError>
typealias APIProducer<T> = SignalProducer<T,APIError>
typealias AnyAPIProducer = SignalProducer<Any?,APIError>

typealias NAction<I,O> = Action<I,O,NoError>
typealias AnyAction = Action<Any?,Any?,NoError>
typealias APIAction<I,O> = Action<I,O,APIError>
typealias AnyAPIAction = Action<Any?,Any?,APIError>

extension SignalProducer where Error == APIError {
    @discardableResult
    func startWithValues(_ action: (Value) -> Void) -> Disposable {
        return startWithValues(action)
    }
}

