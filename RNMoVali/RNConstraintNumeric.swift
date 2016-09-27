//
//  RNConstraintNumeric.swift
//  RNMoVali
//
//  Created by mothule on 2016/08/23.
//  Copyright © 2016年 mothule. All rights reserved.
//

import Foundation

open class RNConstraintNumeric : RNConstraintable {
    
    fileprivate let errorMessage:String
    
    public init(errorMessage:String){
        self.errorMessage = errorMessage
    }
    
    open func constrain(_ object:Any?) -> RNConstraintResult{
        let ret = RNConstraintResult()
        if let string = object as? String{
            
            guard !string.isEmpty else {
                return ret
            }
            
            if Regex.make("^[0-9]+$").isMatch(string) == false {
                ret.invalidate(errorMessage)
            }            
        }
        return ret
    }
}
