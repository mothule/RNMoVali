//
//  RNConstraintNumeric.swift
//  RNMoVali
//
//  Created by mothule on 2016/08/23.
//  Copyright © 2016年 mothule. All rights reserved.
//

import Foundation

public class RNConstraintNumeric : RNConstraintable {
    
    private let errorMessage:String
    
    public init(errorMessage:String){
        self.errorMessage = errorMessage
    }
    
    public func constrain(object:Any?) -> RNConstraintResult{
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