//
//  RNMoValiTests.swift
//  RNMoValiTests
//
//  Created by mothule on 2016/08/23.
//  Copyright © 2016年 mothule. All rights reserved.
//

import XCTest
@testable import RNMoVali

class RNMoValiTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    class TestEntity : RNValidatable {
        var name:String = ""
        var age:Int = 0
        
        func bindConstraint(binder: RNConstraintBinder) {
            binder.bind(name, accessTag:"name")
                .addConstraint(RNConstraintLength(max:10, errorMessage:"character length is 10"))
                .addConstraint(RNConstraintNumeric(errorMessage:"only numeric"))
        }
    }
    
    func test_() {
        let target = TestEntity()
        
        target.name = "0123456789"
        var ret = RNValidator.sharedInstance.validate(target)
        XCTAssertEqual(ret.isValid, true)
        XCTAssertEqual(ret.fields.count, 0)
        
        target.name = "01234567890"
        ret = RNValidator.sharedInstance.validate(target)
        XCTAssertEqual(ret.isValid, false)
        XCTAssertEqual(ret.fields["name"], "character length is 10")
        
        target.name = "012345678a"
        ret = RNValidator.sharedInstance.validate(target)
        XCTAssertEqual(ret.isValid, false)
        XCTAssertEqual(ret.fields["name"], "only numeric")
        
        
    }
    
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measureBlock {
//            // Put the code you want to measure the time of here.
//        }
//    }
    
}
