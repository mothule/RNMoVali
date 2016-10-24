//
//  DmyUtils.swift
//  RNMoVali
//
//  Created by mothule on 2016/10/24.
//  Copyright © 2016年 mothule. All rights reserved.
//

import Foundation


extension String {
    static func * (left:String, right:Int) -> String {
        var arr = ""
        (0..<right).forEach{ _ in arr += left }
        return arr
    }
}
