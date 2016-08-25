//
//  RNValidator.swift
//  RNMoVali
//
//  Created by mothule on 2016/08/23.
//  Copyright © 2016年 mothule. All rights reserved.
//

import Foundation

/**
    Constrain able to protocol for validator
 */
public protocol RNConstraintable {
    func constrain(object: Any?) -> RNConstraintResult
}

public class RNConstraintResult {
    var errorMessage: String?
    var isValid: Bool = true
    var isInvalid: Bool {
        return !isValid
    }
    func invalidate(errorMessage: String? = nil) {
        isValid = false
        if errorMessage != nil {
            self.errorMessage = errorMessage
        }
    }
}

/**
    validate able to protocol for model
 */
public protocol RNValidatable: AnyObject {
    func bindConstraint(binder: RNConstraintBinder)
}


public class RNValidationResult {
    public class Value {
        var messages: [String] = []
        var isContainsError: Bool {
            return messages.count > 0
        }
    }

    var fields: [String: Value] = [:]

    subscript (tag: String) -> Value? {
        get {
            if fields.contains({k, _ in k == tag}) {
                return fields[tag]
            }
            return nil
        }
    }

    public var isValid: Bool {
        return fields.count <= 0
    }
    public var isInvalid: Bool { return !isValid }

    private func append(tag: String, message: String) {
        let v: Value
        if fields.contains({k, _ in k == tag}) {
            v = fields[tag]!
        } else {
           v = Value()
        }
        v.messages.append(message)
        fields[tag] = v
    }
}

/**
    Entry instance.
 */
public class RNValidator {
    // Singleton instance.
    public static let sharedInstance: RNValidator = RNValidator()
    private init() {
    }

    public func validate(targetModel: RNValidatable) -> RNValidationResult {
        let results: RNValidationResult = RNValidationResult()


        // ターゲットの制約をバインダーに集約.
        let binder:RNConstraintBinder = RNConstraintBinder(targetModel: targetModel)
        targetModel.bindConstraint(binder)

        // 全ての制約のチェック.
        // 全て実行して失敗のみを格納する.
        binder.constraints.forEach { set in
            set.constraints.forEach { constraintable in
                let constraintResult: RNConstraintResult = constraintable.constrain(set.field)
                if constraintResult.isInvalid {
                    results.append(set.tag, message: constraintResult.errorMessage! )
                }
            }
        }

        return results
    }
}
