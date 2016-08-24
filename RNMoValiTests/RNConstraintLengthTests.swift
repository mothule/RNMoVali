//
//  RNConstraintLengthTests.swift
//  RNMoVali
//
//  Created by mothule on 2016/08/25.
//  Copyright © 2016年 mothule. All rights reserved.
//

import XCTest

class Hoge{ var age:Int = 0 }

class RNConstraintLengthTests: XCTestCase {

    //MARK: - Constructor
    // コンストラクタ(max:errorMessage:) 正常に作成されるべき
    func test_Constructor_SetMaxAndErrorMessage_Created(){
        let _:RNConstraintLength = RNConstraintLength(max: 25, errorMessage: "Error")
    }
    // コンストラクタ(min:max:errorMessage) 正常に作成されるべき
    func test_Constructor_SetMinAndMaxAndErrorMessage_Created(){
        let _:RNConstraintLength = RNConstraintLength(min:10, max: 25, errorMessage: "Error")
    }
    
    
    //MARK: - constrain
    // 引数にnilの場合は、バリデーションエラーにならない。
    func test_constrain_SetNil_ReturnDefault(){
        let target:RNConstraintLength = RNConstraintLength(max: 25, errorMessage: "Error")
        let ret:RNConstraintResult = target.constrain(nil)
        XCTAssertEqual(ret.isValid, true)
    }
    
    // 引数にString以外の場合は、バリデーションエラーにならない。
    func test_constrain_SetNonString_ReturnDefault(){
        let target:RNConstraintLength = RNConstraintLength(max: 25, errorMessage: "Error")
        XCTAssertEqual(target.constrain(0).isValid, true)
        XCTAssertEqual(target.constrain(0.0).isValid, true)
        XCTAssertEqual(target.constrain(Hoge()).isValid, true)
    }
    
    // 引数にStringの場合は、バリデーションエラーにならない。
    func test_constrain_SetNotOptionString_ReturnDefault(){
        let target:RNConstraintLength = RNConstraintLength(max: 25, errorMessage: "Error")
        let ret:RNConstraintResult = target.constrain("hoge")
        XCTAssertEqual(ret.isValid, true)
    }
    
    // 引数にString?の場合は、バリデーションエラーにならない。
    func test_constrain_SetOptionString_ReturnDefault(){
        let target:RNConstraintLength = RNConstraintLength(max: 25, errorMessage: "Error")
        let hoge:String? = "hoge"
        let ret:RNConstraintResult = target.constrain(hoge)
        XCTAssertEqual(ret.isValid, true)
    }
    
    // バリデーションエラー時は、エラーメッセージを返すべき。
    func test_constrain_WhenInvalid_ReturnErrorMessage(){
        let target:RNConstraintLength = RNConstraintLength(max: 1, errorMessage: "Error")
        let hoge:String? = "012345678"
        let ret:RNConstraintResult = target.constrain(hoge)
        XCTAssertEqual(ret.isValid, false)
        XCTAssertEqual(ret.errorMessage!, "Error")
    }
    
    // 文字数がmin未満の場合は、バリデーションエラーとなるべし
    func test_constrain_SetNotEnoughString_ReturnInvalid(){
        let target:RNConstraintLength = RNConstraintLength(min:10, max: 25, errorMessage: "Error")
        let hoge:String? = "012345678"
        let ret:RNConstraintResult = target.constrain(hoge)
        XCTAssertEqual(ret.isValid, false)
    }

    // 文字数がmax超えの場合は、バリデーションエラーとなるべし
    func test_constrain_SetOverString_ReturnInvalid(){
        let target:RNConstraintLength = RNConstraintLength(max: 5, errorMessage: "Error")
        let hoge:String? = "0123456"
        let ret:RNConstraintResult = target.constrain(hoge)
        XCTAssertEqual(ret.isValid, false)
    }
}
