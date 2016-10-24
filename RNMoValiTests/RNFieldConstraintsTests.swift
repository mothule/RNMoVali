//
//  RNFieldConstraintsTests.swift
//  RNMoVali
//
//  Created by 川上 基樹 on 2016/08/25.
//  Copyright © 2016年 mothule. All rights reserved.
//

import XCTest

class RNFieldConstraintsTests: XCTestCase {

    //MARK: -  Constructor
    // 各フィールドが想定通り保持できている
    func test_Constructor_Simple_HaveEachFields() {
        let string: String = "hoge"
        let target: RNFieldConstraints = RNFieldConstraints(field: string, tag: "string")
        (target.field as? String)?.is("hoge")
        target.tag.is("string")
        target.constraints.count.is(0)
    }
}
