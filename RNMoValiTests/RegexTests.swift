//
//  Regex.swift
//  RNMoVali
//
//  Created by 川上 基樹 on 2016/08/25.
//  Copyright © 2016年 mothule. All rights reserved.
//

import XCTest

class RegexTests: XCTestCase {

    //MARK: - make method
    func test_make_Pattern_HaveNSRegularExpression() {
        let regexIns = Regex.make("pattern")
        regexIns.regex.pattern.is("pattern")
    }
    func test_make_PatternWithOptionsNoOption_HaveNSRegularExpresison() {
        let regexIns = Regex.make("pattern", options: [])
        regexIns.regex.pattern.is("pattern")
    }
    func test_make_PatternWithOption__HaveNSRegularExpresison() {
        let regexIns = Regex.make("pattern", options: .caseInsensitive)
        regexIns.regex.pattern.is("pattern")
        XCTAssertEqual(regexIns.regex.options, [.caseInsensitive])
    }

    //MAKR: - isMatch
    func test_isMatch_PatternOnlyNumeric_Work() {
        let regexIns = Regex.make("^[0-9]+$")
        regexIns.isMatch("0").is(true)
        regexIns.isMatch("0123456790").is(true)
        regexIns.isMatch("").is(false)
        regexIns.isMatch("a").is(false)
        regexIns.isMatch("a0").is(false)
        regexIns.isMatch("0a").is(false)
    }

    func test_isMatch_PatternOnlyNumeric2_Work() {
        let regexIns = Regex.make("^\\d+$")
        regexIns.isMatch("0").is(true)
        regexIns.isMatch("0123456790").is(true)
        regexIns.isMatch("").is(false)
        regexIns.isMatch("a").is(false)
        regexIns.isMatch("a0").is(false)
        regexIns.isMatch("0a").is(false)
    }

    func test_isMatch_HaveOptions_Work() {
        let regexIns = Regex.make("^[a-z]+$", options: .caseInsensitive)
        regexIns.isMatch("a").is(true)
        regexIns.isMatch("A").is(true)
    }
}
