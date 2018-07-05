//
//  UIViewController+Binding.swift
//  Databinding
//
//  Created by Xiaowen Ji on 05/07/2018.
//  Copyright © 2018 Xiaowen Ji. All rights reserved.
//

import UIKit

public extension UIViewController {
    
    public func bindAll() {
        bindAll(view: view)
    }
    
    public func bindAll(view: UIView?) {
        guard let view = view else { return }
        view.subviews.forEach {
            bindAll(view: $0)
        }
        (view as? Bindable)?.bind()
    }
}
