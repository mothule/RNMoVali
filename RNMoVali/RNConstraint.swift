//
//  RNConstraint.swift
//  RNMoVali
//
//  Created by mothule on 2016/08/25.
//  Copyright © 2016年 mothule. All rights reserved.
//

import Foundation


// Container class.
// It present a relation of Field and Constraints.
open class RNFieldConstraints {
    let field: Any?
    let tag: String
    var constraints: [RNConstraintable] = []
    
    init(field: Any?, tag: String) {
        self.field = field
        self.tag = tag
    }
}

// A Binder class to bind constraints to field.
open class RNConstraintBinder {
    private var targetModel: RNValidatable
    internal var constraints: [RNFieldConstraints] = []
    
    public init(targetModel: RNValidatable) {
        self.targetModel = targetModel
    }
    
    open func bind(field: Any?, accessTag: String) -> RNConstraintAppender {
        let fieldConstraints = RNFieldConstraints(field: field, tag:accessTag)
        let appender = RNConstraintAppender(owner:fieldConstraints)
        constraints.append(fieldConstraints)
        return appender
    }
}

// 制約加えるクラス.
// 制約は自分は持たずにコンストラクタ時に受け取ったオーナーに渡す.
// It will Append constraint to owner.
open class RNConstraintAppender {
    
    fileprivate weak var owner: RNFieldConstraints!
    
    fileprivate init(owner: RNFieldConstraints) {
        self.owner = owner
    }
    
    open func add(constraint: RNConstraintable) -> RNConstraintAppender {
        owner.constraints.append(constraint)
        return self
    }
}
