//
//  Assert+Any.swift
//  RNMoVali
//
//  Created by mothule on 2016/10/24.
//  Copyright © 2016年 mothule. All rights reserved.
//

import Foundation
import XCTest

protocol Expressible{
    associatedtype ItemType
    func `is`(_ expectedValue:ItemType)
}

extension Bool : Expressible {
    func `is`(_ expectedValue:Bool){
        XCTAssertEqual(self, expectedValue)
    }
}
extension String : Expressible {
    func `is`(_ expectedValue:String){
        XCTAssertEqual(self, expectedValue)
    }
}
extension Int : Expressible {
    func `is`(_ expectedValue:Int){
        XCTAssertEqual(self, expectedValue)
    }
}
