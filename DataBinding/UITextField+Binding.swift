//
//  UITextField+Binding.swift
//  Databinding
//
//  Created by Xiaowen Ji on 05/07/2018.
//  Copyright © 2018 Xiaowen Ji. All rights reserved.
//

import UIKit

extension UITextField: Bindable {
    
    private struct AssociatedKeys {
        static var textKey = "TextKey"
        static var placeholderKey = "PlaceholderKey"
    }
    
    @IBInspectable var textKey: String? {
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.textKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.textKey) as? String
        }
    }
    
    @IBInspectable var placeholderKey: String? {
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.placeholderKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.placeholderKey) as? String
        }
    }
    
    public func bind() {
        if let textKey = textKey {
            text = bindingValue(for: textKey)
        }
        if let placeholderKey = placeholderKey {
            placeholder = bindingValue(for: placeholderKey)
        }
        addTarget(self, action: #selector(textDidChange(_:)), for: .editingChanged)
    }
    
    @objc fileprivate func textDidChange(_ sender: UITextField) {
        if let textKey = textKey {
            setBindingValue(text, for: textKey)
        }
    }
}
