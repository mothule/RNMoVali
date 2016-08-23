//
//  RNValidator.swift
//  RNMoVali
//
//  Created by mothule on 2016/08/23.
//  Copyright © 2016年 mothule. All rights reserved.
//

import Foundation


public class RNConstraintSet {
    var field:AnyObject
    var constraints:Array<RNConstraintable> = Array<RNConstraintable>()
    var tag:String
    
    init(field:AnyObject, constraint:RNConstraintable, tag:String ){
        self.field = field
        self.constraints.append(constraint)
        self.tag = tag
    }
    init(field:AnyObject, tag:String){
        self.field = field
        self.tag = tag
    }
}

/**
    a method chainable binder for constraints.
 */
public class RNConstraintBinder {
    
    private var targetModel:AnyObject
    private var constraints:Array<RNConstraintSet> = []
    
    public init(targetModel:AnyObject) {
        self.targetModel = targetModel
    }
    
    public func bind(field:AnyObject, accessTag:String) -> RNConstraintAppender{
        let constraintSet = RNConstraintSet(field: field, tag:accessTag)
        let appender:RNConstraintAppender = RNConstraintAppender(owner:constraintSet)
        constraints.append(constraintSet)
        return appender
    }
}

// 制約加えるクラス.
// 制約は自分は持たずにコンストラクタ時に受け取ったオーナーに渡す.
public class RNConstraintAppender {
    
    private weak var owner:RNConstraintSet!
    
    public init(owner:RNConstraintSet){
        self.owner = owner
    }
    
    public func addConstraint(constraint:RNConstraintable) -> RNConstraintAppender{
        owner.constraints.append(constraint)
        return self
    }
}

/**
    Constrain able to protocol for validator
 */
public protocol RNConstraintable {
    func constrain(object:AnyObject) -> RNConstraintResult
}
public class RNConstraintResult {
    var errorMessage:String?
    var isValid:Bool = true
    var isInvalid:Bool {
        return !isValid
    }
    func invalidate(){ isValid = false }
}

/**
    validate able to protocol for model
 */
public protocol RNValidatable : AnyObject
{
    func bindConstraint(binder:RNConstraintBinder)
}


public class RNValidationResult {
    var fields:Dictionary<String, String> = Dictionary<String, String>()
    
    subscript (tag:String) -> String {
        get {
            return (fields[tag])!
        }
    }
    
    public var isValid:Bool {
        return fields.count <= 0
    }
    private func append(tag:String, message:String){
        fields[tag] = message
    }
}

/**
    Entry instance.
 */
public class RNValidator
{
    // Singleton instance.
    public static let sharedInstance:RNValidator = RNValidator()
    private init(){
    }

    public func validate(targetModel:RNValidatable) -> RNValidationResult
    {
        let results:RNValidationResult = RNValidationResult()


        // ターゲットの制約をバインダーに集約.
        let binder:RNConstraintBinder = RNConstraintBinder(targetModel: targetModel)
        targetModel.bindConstraint(binder)
        
        // 全ての制約のチェック.
        // 全て実行して失敗のみを格納する.
        binder.constraints.forEach{ set in
            set.constraints.forEach{ constraintable in
                let constraintResult:RNConstraintResult = constraintable.constrain(set.field)
                if constraintResult.isInvalid {
                    results.append(set.tag, message: constraintResult.errorMessage! )
                }
            }
        }

        return results
    }
}