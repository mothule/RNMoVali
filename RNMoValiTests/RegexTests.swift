//
//  Regex.swift
//  RNMoVali
//
//  Created by 川上 基樹 on 2016/08/25.
//  Copyright © 2016年 mothule. All rights reserved.
//

import XCTest

class RegexTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    //MARK: - make method
    func test_make_Pattern_HaveNSRegularExpression() {
        let regexIns = Regex.make("pattern")
        XCTAssertEqual(regexIns.regex.pattern, "pattern")
    }
    func test_make_PatternWithOptionsNoOption_HaveNSRegularExpresison() {
        let regexIns = Regex.make("pattern", options: [])
        XCTAssertEqual(regexIns.regex.pattern, "pattern")
    }
    func test_make_PatternWithOption__HaveNSRegularExpresison() {
        let regexIns = Regex.make("pattern", options: .CaseInsensitive)
        XCTAssertEqual(regexIns.regex.pattern, "pattern")
        XCTAssertEqual(regexIns.regex.options, [.CaseInsensitive])
    }

    //MAKR: - isMatch
    func test_isMatch_PatternOnlyNumeric_Work() {
        let regexIns = Regex.make("^[0-9]+$")
        XCTAssertTrue(regexIns.isMatch("0"))
        XCTAssertTrue(regexIns.isMatch("0123456790"))
        XCTAssertFalse(regexIns.isMatch(""))
        XCTAssertFalse(regexIns.isMatch("a"))
        XCTAssertFalse(regexIns.isMatch("a0"))
        XCTAssertFalse(regexIns.isMatch("0a"))
    }

    func test_isMatch_PatternOnlyNumeric2_Work() {
        let regexIns = Regex.make("^\\d+$")
        XCTAssertTrue(regexIns.isMatch("0"))
        XCTAssertTrue(regexIns.isMatch("0123456790"))
        XCTAssertFalse(regexIns.isMatch(""))
        XCTAssertFalse(regexIns.isMatch("a"))
        XCTAssertFalse(regexIns.isMatch("a0"))
        XCTAssertFalse(regexIns.isMatch("0a"))
    }

    func test_isMatch_HaveOptions_Work() {
        let regexIns = Regex.make("^[a-z]+$", options: .CaseInsensitive)
        XCTAssertTrue(regexIns.isMatch("a"))
        XCTAssertTrue(regexIns.isMatch("A"))
    }
}
