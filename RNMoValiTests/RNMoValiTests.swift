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

    /**
     Mock class 1.
     */
    class TestEntity: RNValidatable {
        static let NameLengthErrorMessage = "character length is 10"
        static let NameOnlyNumericErrorMessage = "only numeric"
        
        var name: String = ""
        var age: Int = 0

        func bindConstraint(binder: RNConstraintBinder) {
            _ = binder.bind(field: name, accessTag:"name")
                .add( constraint: RNConstraintLength(max:10, errorMessage:TestEntity.NameLengthErrorMessage))
                .add(constraint: RNConstraintNumeric(errorMessage: TestEntity.NameOnlyNumericErrorMessage))
        }
    }

    /**
     Mock class 2.
    */
    class Profile: RNValidatable {
        static let NameRequiredErrorMessage = "Input the name."
        static let NameLengthErrorMessage = "The name Try to 20 characters or less"

        var name: String?
        var gender: Int?

        func bindConstraint(binder: RNConstraintBinder) {
            _ = binder.bind(field: name, accessTag: "name")
                .add(constraint: RNConstraintRequired(errorMessage: Profile.NameRequiredErrorMessage))
                .add(constraint: RNConstraintLength(min:1, max: 20, errorMessage: Profile.NameLengthErrorMessage))
        }
    }
    
    /**
    Mock class 3
    */
    class MixedClass : RNValidatable {
        var name:String?
        var value:Int = 0
        var areaCode:Int = 0
        
        func bindConstraint( binder: RNConstraintBinder) {
            _ = binder.bind(field: name, accessTag: "name")
                .add( constraint: RNConstraintRequired(errorMessage: "It must have a name."))
                .add(constraint: RNConstraintLength(max: 10, errorMessage: "10 characters or less"))
            
            _ = binder.bind(field: value, accessTag: "value")
                .add(constraint: RNConstraintRange<Int>(min: 0, max: 10000, errorMessage: "It is 0 to 10000"))
            
            _ = binder.bind(field: areaCode, accessTag: "areaCode")
                .add(constraint: RNConstraintRange<Int>(min: 0, max: 10, errorMessage: "It is 0 to 10"))
        }
    }
    
    

    // 正常系
    // Model内にOption型フィールドが含まれていても正常動作すること.
    func test__Usecase_OptionalFields_Work() {
        let target = Profile()
        
        let ret = target.rn.validate()
        ret.isValid.is(false)
        let nameResult = ret.fields["name"]
        nameResult?.isContainsError.is(true)
        nameResult?.messages[0].is(Profile.NameRequiredErrorMessage)
    }

    // 正常系
    // Model内にOption型フィールドが含まれていなくても、正常動作すること.
    func test__Usecase_NotOptionalFields_Work() {
        let target = TestEntity()
        var ret:RNValidationResult

        target.name = "0" * 10
        ret = target.rn.validate()
        ret.isValid.is(true)
        ret.fields.count.is(0)

        target.name = "0" * 11
        ret = target.rn.validate()
        ret.isValid.is(false)
        ret.fields["name"]?.messages[0].is(TestEntity.NameLengthErrorMessage)

        target.name = "0" * 9 + "a"
        ret = target.rn.validate()
        ret.isValid.is(false)
        ret.fields["name"]?.messages[0].is( TestEntity.NameOnlyNumericErrorMessage )
    }
    
    // 正常系
    // Model内にOption型と非Option型のフィールドが混じってても、正常動作すること.
    func test__Usecase_MixNotOptionalAndOptionalFields_Work()
    {
        let target = MixedClass()
        var ret:RNValidationResult

        // invalid required constraint
        ret = target.rn.validate()
        ret.isValid.is(false)
        ret.fields.count.is(1)
        ret.fields["name"]?.messages.count.is(1)
        ret.fields["name"]?.messages[0].is("It must have a name.")
        
        // valid
        target.name = "monkey"
        target.value = 1
        ret = target.rn.validate()
        ret.isValid.is(true)
        ret.fields.count.is(0)
        
        // invalid over character length and invalid value over range
        target.name = "monkey" * 8
        target.value = -1
        target.areaCode = 11
        ret = target.rn.validate()
        ret.isValid.is(false)
        ret.fields.count.is(3)
        ret.fields["name"]?.messages.count.is(1)
        ret.fields["name"]?.messages[0].is("10 characters or less")
        ret.fields["value"]?.messages.count.is(1)
        ret.fields["value"]?.messages[0].is("It is 0 to 10000")
        ret.fields["areaCode"]?.messages.count.is(1)
        ret.fields["areaCode"]?.messages[0].is("It is 0 to 10")
    }
}
