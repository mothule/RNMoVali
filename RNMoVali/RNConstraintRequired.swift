//
//  RNConstraintRequired.swift
//  RNMoVali
//
//  Created by 川上 基樹 on 2016/08/24.
//  Copyright © 2016年 mothule. All rights reserved.
//

import Foundation

public class RNConstraintRequired: RNConstraintable {

    private let errorMessage: String

    public init(errorMessage: String) {
        self.errorMessage = errorMessage
    }

    public func constrain(object: Any?) -> RNConstraintResult {
        let ret = RNConstraintResult()
        if object == nil {
            ret.errorMessage = errorMessage
            ret.invalidate()
        }
        return ret
    }

    public func constrain(object: AnyObject) -> RNConstraintResult {
        let ret = RNConstraintResult()
        return ret
//        if let _ = object {
//            ret.errorMessage = errorMessage
//            ret.invalidate()
//        }
//        return ret
    }
}
