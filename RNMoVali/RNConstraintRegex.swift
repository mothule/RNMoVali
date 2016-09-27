//
//  RNConstraintRegex.swift
//  RNMoVali
//
//  Created by mothule on 2016/08/24.
//  Copyright © 2016年 mothule. All rights reserved.
//

import Foundation

open class RNConstraintRegex : RNConstraintable
{
    fileprivate let errorMessage:String
    fileprivate let pattern:String
    fileprivate let options:NSRegularExpression.Options?
    
    public init(pattern:String, errorMessage:String, options:NSRegularExpression.Options? = nil){
        self.pattern = pattern
        self.errorMessage = errorMessage
        self.options = options
    }
    
    open func constrain(_ object: Any?) -> RNConstraintResult {
        let ret:RNConstraintResult = RNConstraintResult()
        if let string = object as? String {
            if Regex.make(pattern, options: options).isMatch(string) == false {
                ret.invalidate(self.errorMessage)
            }
        }
        return ret
    }
}
