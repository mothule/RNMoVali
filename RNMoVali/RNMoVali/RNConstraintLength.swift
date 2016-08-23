//
//  RNConstraintLength.swift
//  RNMoVali
//
//  Created by mothule on 2016/08/23.
//  Copyright © 2016年 mothule. All rights reserved.
//

import Foundation

public class RNConstraintLength : RNConstraintable {
    
    private let min:Int
    private let max:Int
    private let errorMessage:String
    
    public init(min:Int, max:Int,  errorMessage:String){
        self.min = min
        self.max = max
        self.errorMessage = errorMessage
        
    }
    public init(max:Int, errorMessage:String){
        self.min = 0
        self.max = max
        self.errorMessage = errorMessage
    }
    
    public func constrain(object:AnyObject) -> RNConstraintResult{
        let ret = RNConstraintResult()
        if let string = object as? String{
            if string.characters.count < min || string.characters.count > max {
                ret.errorMessage = errorMessage
                ret.invalidate()
            }
        }
        return ret
    }
}