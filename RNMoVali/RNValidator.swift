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
    func constrain(_ object: Any?) -> RNConstraintResult
}

open class RNConstraintResult {
    open var errorMessage: String?
    open var isValid: Bool = true
    open var isInvalid: Bool {
        return !isValid
    }
    func invalidate(_ errorMessage: String? = nil) {
        isValid = false
        if errorMessage != nil {
            self.errorMessage = errorMessage
        }
    }
}

/**
    validate able to protocol for model
 */
public protocol RNValidatable {
    func bindConstraint(binder: RNConstraintBinder)
}

/**
    Validatable extension.
 */
public extension RNValidatable {
    public var rn:RNValidationProvider{ get{ return RNValidationProvider(validatable: self) } }
}

/**
    Validation provider for validatable.
    @warn do not keep it scope out. it have unowned var.
 */
public struct RNValidationProvider {
    private var validatable:RNValidatable
    public init(validatable:RNValidatable){
        self.validatable = validatable
    }
    public func validate() -> RNValidationResult {
        return RNValidator.shared.validate(validatable)
    }
}


open class RNValidationResult {
    open class Value {
        open var messages: [String] = []
        open var isContainsError: Bool {
            return messages.count > 0
        }
    }

    open var fields: [String: Value] = [:]

    open subscript (tag: String) -> Value? {
        get {
            if fields.contains(where: {k, _ in k == tag}) {
                return fields[tag]
            }
            return nil
        }
    }

    open var isValid: Bool {
        return fields.count <= 0
    }
    open var isInvalid: Bool { return !isValid }

    fileprivate func append(_ tag: String, message: String) {
        let v: Value
        if fields.contains(where: {k, _ in k == tag}) {
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
open class RNValidator {
    // Singleton instance.
    open static let shared: RNValidator = RNValidator()
    fileprivate init() {
    }

    open func validate(_ targetModel: RNValidatable) -> RNValidationResult {
        let results: RNValidationResult = RNValidationResult()


        // ターゲットの制約をバインダーに集約.
        let binder:RNConstraintBinder = RNConstraintBinder(targetModel: targetModel)
        targetModel.bindConstraint(binder: binder)

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
