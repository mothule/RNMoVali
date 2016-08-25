//
//  RNConstrainRange.swift
//  RNMoVali
//
//  Created by mothule on 2016/08/26.
//  Copyright © 2016年 mothule. All rights reserved.
//

import Foundation

public class RNConstraintRange<T where T:Comparable> : RNConstraintable {
    
    private let min:T
    private let max:T
    private let errorMessage:String
    
    public init(min:T, max:T,  errorMessage:String){
        self.min = min
        self.max = max
        self.errorMessage = errorMessage
    }
    
    public func constrain(object:Any?) -> RNConstraintResult{
        let ret = RNConstraintResult()
        if let value = object as? T{
            if value < min || value > max {
                ret.invalidate(errorMessage)
            }
        }
        return ret
    }
}