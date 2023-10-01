//
//  Observable.swift
//  ga-starwars-swift
//
//  Created by Developer on 01/10/2023.
//

import Foundation

// MARK: - ObserverProtocol Type

private protocol ObserverProtocol {
    associatedtype Value
    associatedtype T
    
    var observers: T { get }
    var value: Value { get }
    
    func observe(on observer: AnyObject, block: @escaping (Value) -> Void)
    func remove(observer: AnyObject)
    func notifyObservers()
}

// MARK: - Observable Type

final class Observable<Value> {
    fileprivate var observers = [Observer<Value>]()
    
    var value: Value { didSet { notifyObservers() } }
    
    init(_ value: Value) {
        self.value = value
    }
}

// MARK: - Observer Type

extension Observable {
    fileprivate struct Observer<Value> {
        private(set) weak var observer: AnyObject?
        let block: (Value) -> Void
    }
}

// MARK: - ObserverProtocol Implementation

extension Observable: ObserverProtocol {
    fileprivate func notifyObservers() {
        for observer in observers {
            mainQueueDispatch { observer.block(self.value) }
        }
    }
    
    func observe(on observer: AnyObject, block: @escaping (Value) -> Void) {
        let observer = Observer(observer: observer, block: block)
        observers.append(observer)
        block(self.value)
    }
    
    func remove(observer: AnyObject) {
        observers = observers.filter { $0.observer !== observer }
    }
}
