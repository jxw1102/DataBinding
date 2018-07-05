//
//  UILabel+Binding.swift
//  Databinding
//
//  Created by Xiaowen Ji on 04/07/2018.
//  Copyright © 2018 Xiaowen Ji. All rights reserved.
//

import UIKit

extension UILabel: Bindable {
    
    private struct AssociatedKeys {
        static var textKey = "TextKey"
    }
    
    @IBInspectable var textKey: String? {
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.textKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.textKey) as? String
        }
    }
    
    public func bind() {
        if let textKey = textKey {
            text = bindingValue(for: textKey)
        }
    }
}
