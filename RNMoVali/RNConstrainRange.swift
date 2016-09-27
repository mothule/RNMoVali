//
//  RNConstrainRange.swift
//  RNMoVali
//
//  Created by mothule on 2016/08/26.
//  Copyright © 2016年 mothule. All rights reserved.
//

import Foundation

open class RNConstraintRange<T> : RNConstraintable where T:Comparable {
    
    fileprivate let min:T
    fileprivate let max:T
    fileprivate let errorMessage:String
    
    public init(min:T, max:T,  errorMessage:String){
        self.min = min
        self.max = max
        self.errorMessage = errorMessage
    }
    
    open func constrain(_ object:Any?) -> RNConstraintResult{
        let ret = RNConstraintResult()
        if let value = object as? T{
            if value < min || value > max {
                ret.invalidate(errorMessage)
            }
        }
        return ret
    }
}
