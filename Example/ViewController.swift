//
//  ViewController.swift
//  Databinding
//
//  Created by Xiaowen Ji on 04/07/2018.
//  Copyright © 2018 Xiaowen Ji. All rights reserved.
//

import UIKit
import DataBinding

class MyViewModel: NSObject {
    var labelText = ObservableField("Adder")
    var placeholder = "write a number here"
    var buttonTitle = "Calculate"
    var inputText1 = ObservableField<String>()
    var inputText2 = ObservableField<String>()
    
    @objc func submit() {
        if let num1 = Int(self.inputText1.value ?? ""), let num2 = Int(self.inputText2.value ?? "") {
            self.labelText.value = "\(num1 + num2)"
        } else {
            self.labelText.value = "NaN"
        }
    }
}

class ViewController: UIViewController, MvvmViewController {

    @IBOutlet weak var label: UILabel!
    
    var viewModel: MyViewModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewModel = MyViewModel()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addViewModelToSubviews()
        bindAll()
    }
}
