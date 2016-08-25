//
//  RNFieldConstraintsTests.swift
//  RNMoVali
//
//  Created by 川上 基樹 on 2016/08/25.
//  Copyright © 2016年 mothule. All rights reserved.
//

import XCTest

class RNFieldConstraintsTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    //MARK: -  Constructor
    // 各フィールドが想定通り保持できている
    func test_Constructor_Simple_HaveEachFields() {
        let string: String = "hoge"
        let target: RNFieldConstraints = RNFieldConstraints(field: string, tag: "string")
        XCTAssertEqual((target.field as? String), "hoge")
        XCTAssertEqual(target.tag, "string")
        XCTAssertEqual(target.constraints.count, 0)
    }
}
