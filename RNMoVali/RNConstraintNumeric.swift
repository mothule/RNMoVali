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
    
    public func constrain(object:AnyObject) -> RNConstraintResult{
        let ret = RNConstraintResult()
        if let string = object as? String{
            
            guard !string.isEmpty else {
                return ret
            }
            
            let regex: NSRegularExpression
            do {
                let pattern = "^[0-9]+$"
                regex = try NSRegularExpression(pattern: pattern, options: [.CaseInsensitive])
            }catch let error as NSError {
                print("error:\(error)")
                return ret
            }

            // IsMatch
            let results:[NSTextCheckingResult] = regex.matchesInString(string, options: [], range: NSMakeRange(0, string.characters.count))
            if results.count <= 0{
                ret.errorMessage = errorMessage
                ret.invalidate()
            }
        }
        return ret
    }
}