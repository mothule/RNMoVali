//
//  RNConstraintRegex.swift
//  RNMoVali
//
//  Created by mothule on 2016/08/24.
//  Copyright © 2016年 mothule. All rights reserved.
//

import Foundation

public class RNConstraintRegex : RNConstraintable
{
    private let errorMessage:String
    private let pattern:String
    private let options:NSRegularExpressionOptions?
    
    public init(pattern:String, errorMessage:String, options:NSRegularExpressionOptions? = nil){
        self.pattern = pattern
        self.errorMessage = errorMessage
        self.options = options
    }
    
    public func constrain(object: Any?) -> RNConstraintResult {
        let ret:RNConstraintResult = RNConstraintResult()
        if let string = object as? String {
            if Regex.make(pattern, options: options).isMatch(string) == false {
                ret.invalidate(self.errorMessage)
            }
        }
        return ret
    }
}