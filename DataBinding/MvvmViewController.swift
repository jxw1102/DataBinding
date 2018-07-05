//
//  MvvmViewController.swift
//  Databinding
//
//  Created by Xiaowen Ji on 05/07/2018.
//  Copyright © 2018 Xiaowen Ji. All rights reserved.
//

import UIKit

public protocol MvvmViewController: class {
    associatedtype ViewModel: NSObject
    var viewModel: ViewModel! { get set }
}

public extension MvvmViewController where Self: UIViewController {
    
    public func addViewModelToSubviews() {
        view.subviews.forEach {
            $0.viewModel = viewModel
        }
    }
}
