//
//  Regex.swift
//  RNMoVali
//
//  Created by mothule on 2016/08/24.
//  Copyright © 2016年 mothule. All rights reserved.
//

import Foundation




// Regular Expression Entry.
class Regex
{
    class func make(_ pattern:String, options:NSRegularExpression.Options? = nil) -> RegexInstance
    {
        let regex: NSRegularExpression
        let opts:NSRegularExpression.Options = options != nil ? options! : []
        regex = try! NSRegularExpression(pattern: pattern, options: opts)
        return RegexInstance(regex: regex)
    }
}

class RegexInstance
{
    let regex:NSRegularExpression
    init(regex:NSRegularExpression){
        self.regex = regex
    }
    
    // Is matching condition
    func isMatch(_ string:String) -> Bool {
        let ret:[NSTextCheckingResult] = regex.matches(in: string, options: .reportCompletion, range: NSMakeRange(0, string.characters.count))
        return ret.count > 0
    }
}
