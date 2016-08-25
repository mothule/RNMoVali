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
public class RNFieldConstraints {
    let field: Any?
    let tag: String
    var constraints: [RNConstraintable] = []
    
    init(field: Any?, tag: String) {
        self.field = field
        self.tag = tag
    }
}

// A Binder class to bind constraints to field.
public class RNConstraintBinder {
    private var targetModel: AnyObject
    internal var constraints: [RNFieldConstraints] = []
    
    public init(targetModel: AnyObject) {
        self.targetModel = targetModel
    }
    
    public func bind(field: Any?, accessTag: String) -> RNConstraintAppender {
        let fieldConstraints = RNFieldConstraints(field: field, tag:accessTag)
        let appender = RNConstraintAppender(owner:fieldConstraints)
        constraints.append(fieldConstraints)
        return appender
    }
}

// 制約加えるクラス.
// 制約は自分は持たずにコンストラクタ時に受け取ったオーナーに渡す.
// It will Append constraint to owner.
public class RNConstraintAppender {
    
    private weak var owner: RNFieldConstraints!
    
    private init(owner: RNFieldConstraints) {
        self.owner = owner
    }
    
    public func addConstraint(constraint: RNConstraintable) -> RNConstraintAppender {
        owner.constraints.append(constraint)
        return self
    }
}
