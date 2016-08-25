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

    class TestEntity: RNValidatable {
        var name: String = ""
        var age: Int = 0

        func bindConstraint(binder: RNConstraintBinder) {
            binder.bind(name, accessTag:"name")
                .addConstraint(RNConstraintLength(max:10, errorMessage:"character length is 10"))
                .addConstraint(RNConstraintNumeric(errorMessage:"only numeric"))
        }
    }

    class Profile: RNValidatable {
        static let NameRequiredErrorMessage = "Input the name."
        static let NameLengthErrorMessage = "The name Try to 20 characters or less"

        var name: String?
        var gender: Int?

        func bindConstraint(binder: RNConstraintBinder) {
            binder.bind(name, accessTag: "name")
            .addConstraint(RNConstraintRequired(errorMessage: Profile.NameRequiredErrorMessage))
                .addConstraint(RNConstraintLength(min:1, max: 20, errorMessage: Profile.NameLengthErrorMessage))
        }
    }

    // 正常系
    // Model内にOption型フィールドが含まれていても正常動作すること.
    func test__Usecase_OptionalFields_Work() {
        let target = Profile()
        let ret: RNValidationResult = RNValidator.sharedInstance.validate(target)
        XCTAssertEqual(ret.isValid, false)

        let nameResult = ret.fields["name"]
        XCTAssertEqual(nameResult?.isContainsError, true)
        XCTAssertEqual(nameResult?.messages[0], Profile.NameRequiredErrorMessage)
    }

    // 正常系
    // Model内にOption型フィールドが含まれていなくても、正常動作すること.
    func test__Usecase_NotOptionalFields_Work() {
        let target = TestEntity()

        target.name = "0123456789"
        var ret = RNValidator.sharedInstance.validate(target)
        XCTAssertEqual(ret.isValid, true)
        XCTAssertEqual(ret.fields.count, 0)

        target.name = "01234567890"
        ret = RNValidator.sharedInstance.validate(target)
        XCTAssertEqual(ret.isValid, false)
        XCTAssertEqual(ret.fields["name"]?.messages[0], "character length is 10")

        target.name = "012345678a"
        ret = RNValidator.sharedInstance.validate(target)
        XCTAssertEqual(ret.isValid, false)
        XCTAssertEqual(ret.fields["name"]?.messages[0], "only numeric")
    }
    
    // Model内にOption型と非Option型のフィールドが混じってても、正常動作すること.
    func test__Usecase_MixNotOptionalAndOptionalFields_Work()
    {
        class MixedClass : RNValidatable {
            var name:String?
            var value:Int = 0
            var areaCode:Int = 0
            
            private func bindConstraint(binder: RNConstraintBinder) {
                binder.bind(name, accessTag: "name")
                    .addConstraint(RNConstraintRequired(errorMessage: "It must have a name."))
                    .addConstraint(RNConstraintLength(max: 10, errorMessage: "10 characters or less"))
                binder.bind(value, accessTag: "value")
                    .addConstraint(RNConstraintRange<Int>(min: 0, max: 10000, errorMessage: "It is 0 to 10000"))
                binder.bind(areaCode, accessTag: "areaCode")
                    .addConstraint(RNConstraintRange<Int>(min: 0, max: 10, errorMessage: "It is 0 to 10"))
            }
        }
        
        // invalid required constraint
        let target = MixedClass()
        var ret = RNValidator.sharedInstance.validate(target)
        XCTAssertEqual(ret.isValid,false)
        XCTAssertEqual(ret.fields.count, 1)
        XCTAssertEqual(ret.fields["name"]?.messages.count, 1)
        XCTAssertEqual(ret.fields["name"]?.messages[0], "It must have a name.")
        
        // valid
        target.name = "monkey"
        target.value = 1
        ret = RNValidator.sharedInstance.validate(target)
        XCTAssertEqual(ret.isValid,true)
        XCTAssertEqual(ret.fields.count, 0)
        
        // invalid over character length and invalid value over range
        target.name = "monkeymonkeymonkeymonkeymonkeymonkeymonkeymonkey"
        target.value = -1
        target.areaCode = 11
        ret = RNValidator.sharedInstance.validate(target)
        XCTAssertEqual(ret.isValid,false)
        XCTAssertEqual(ret.fields.count, 3)
        XCTAssertEqual(ret.fields["name"]?.messages.count,1)
        XCTAssertEqual(ret.fields["name"]?.messages[0], "10 characters or less")
        XCTAssertEqual(ret.fields["value"]?.messages.count,1)
        XCTAssertEqual(ret.fields["value"]?.messages[0], "It is 0 to 10000")
        XCTAssertEqual(ret.fields["areaCode"]?.messages.count,1)
        XCTAssertEqual(ret.fields["areaCode"]?.messages[0], "It is 0 to 10")
    }

}
