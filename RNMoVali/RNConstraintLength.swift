//
//  RNConstraintLength.swift
//  RNMoVali
//
//  Created by mothule on 2016/08/23.
//  Copyright © 2016年 mothule. All rights reserved.
//

import Foundation

open class RNConstraintLength : RNConstraintable {
    
    fileprivate let min:Int
    fileprivate let max:Int
    fileprivate let errorMessage:String
    
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
    
    open func constrain(_ object:Any?) -> RNConstraintResult{
        let ret = RNConstraintResult()
        if let string = object as? String{
            if string.characters.count < min || string.characters.count > max {
                ret.invalidate(errorMessage)
            }
        }
        return ret
    }
}
