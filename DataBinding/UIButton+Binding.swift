//
//  UIButton+Binding.swift
//  Databinding
//
//  Created by Xiaowen Ji on 05/07/2018.
//  Copyright © 2018 Xiaowen Ji. All rights reserved.
//

import UIKit

extension UIButton: Bindable {
    
    private struct AssociatedKeys {
        static var closureKey = "ClosureKey"
        static var selectorKey = "SelectorKey"
        static var titleKey = "TitleKey"
    }
    
    @IBInspectable var titleKey: String? {
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.titleKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.titleKey) as? String
        }
    }
    
    @IBInspectable var selectorKey: String? {
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.selectorKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.selectorKey) as? String
        }
    }
    
    @IBInspectable var closureKey: String? {
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.closureKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.closureKey) as? String
        }
    }
    
    public func bind() {
        if let titleKey = titleKey {
            setTitle(bindingValue(for: titleKey), for: .normal)
        }
        if let selectorKey = selectorKey, let viewModel = viewModel {
            addTarget(viewModel, action: NSSelectorFromString(selectorKey), for: .touchUpInside)
        }
        addTarget(self, action: #selector(didClick(_:)), for: .touchUpInside)
    }
    
    @objc fileprivate func didClick(_ sender: UIButton) {
        if let closureKey = closureKey {
            let closure: (() -> Void)? = bindingValue(for: closureKey)
            closure?()
        }
    }
}
