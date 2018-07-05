//
//  Models.swift
//  Databinding
//
//  Created by Xiaowen Ji on 04/07/2018.
//  Copyright © 2018 Xiaowen Ji. All rights reserved.
//

import UIKit

public protocol Bindable {
    func bind()
}

public extension Bindable where Self: UIView {
    
    public func bindingValue<T>(for key: String) -> T? {
        let value: (ObservableField<T>?, T?) = findValue(for: key)
        if value.0 != nil {
            value.0?.addListener(self)
            return value.0?.value
        } else {
            return value.1
        }
    }
    
    public func setBindingValue<U>(_ value: U?, for key: String) {
        let observable: ObservableField<U>? = findObservable(for: key)
        observable?._value = value
    }
}

public extension UIView {
    
    private struct AssociatedKeys {
        static var viewModelKey = "ViewModel"
    }
    
    @IBOutlet weak var viewModel: NSObject? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.viewModelKey) as? NSObject
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.viewModelKey, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
    }
    
    fileprivate func findValue<T>(for key: String) -> (ObservableField<T>?, T?) {
        if let vm = viewModel {
            let mirror = Mirror(reflecting: vm)
            let value = mirror.children.first(where: { $0.label == key })?.value
            return (value as? ObservableField<T>, value as? T)
        }
        return (nil, nil)
    }
    
    fileprivate func findObservable<T: ObservableField<U>, U>(for key: String) -> T? {
        if let vm = viewModel {
            let mirror = Mirror(reflecting: vm)
            let value = mirror.children.first(where: { $0.label == key })?.value
            return value as? T
        }
        return nil
    }
}

public class WeakReference<T: AnyObject> {
    weak var value: T?
    init(_ val: T?) {
        value = val
    }
}

public class ObservableField<T> {
    
    fileprivate var _value: T?
    private var listeners: [WeakReference<UIView>]
    
    public init() {
        _value = nil
        listeners = []
    }
    
    public init(_ value: T?) {
        _value = value
        listeners = []
    }
    
    public var value: T? {
        get {
            return _value
        }
        set {
            _value = newValue
            listeners.forEach {
                ($0.value as? Bindable)?.bind()
            }
        }
    }
    
    public func addListener(_ listener: UIView & Bindable) {
        if listeners.index(where: { $0.value == listener }) == nil {
            listeners.append(WeakReference(listener))
        }
    }
}
