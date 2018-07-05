//
//  MyViewModelTests.swift
//  DatabindingTests
//
//  Created by Xiaowen Ji on 05/07/2018.
//  Copyright © 2018 Xiaowen Ji. All rights reserved.
//

import XCTest
@testable import Example

class MyViewModelTests: XCTestCase {
    
    var viewModel = MyViewModel()
    
    func testAdd() {
        viewModel.inputText1.value = "100"
        viewModel.inputText2.value = "200"
        viewModel.submit()
        XCTAssertEqual(viewModel.labelText.value, "300")
    }
    
    func testNotANumber() {
        viewModel.inputText1.value = "100"
        viewModel.inputText2.value = "wtf"
        viewModel.submit()
        XCTAssertEqual(viewModel.labelText.value, "NaN")
    }
}
