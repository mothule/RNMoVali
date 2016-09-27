//
//  RNConstraintRequired.swift
//  RNMoVali
//
//  Created by 川上 基樹 on 2016/08/24.
//  Copyright © 2016年 mothule. All rights reserved.
//

import Foundation

open class RNConstraintRequired: RNConstraintable {

    fileprivate let errorMessage: String

    public init(errorMessage: String) {
        self.errorMessage = errorMessage
    }

    open func constrain(_ object: Any?) -> RNConstraintResult {
        let ret = RNConstraintResult()
        if object == nil {
            ret.invalidate(errorMessage)
        }
        return ret
    }
}
