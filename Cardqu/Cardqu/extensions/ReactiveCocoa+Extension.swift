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

typealias ButtonAction = CocoaAction<UIButton>

extension SignalProducer where Error == APIError {
    @discardableResult
    func startWithValues(_ action: @escaping (Value) -> Void) -> Disposable {
        return start(Signal.Observer(value: action))
    }
}

extension CocoaAction {
    public convenience init<Output, Error>(_ action: Action<Any?, Output, Error>) {
        self.init(action, input: nil)
    }
}
