//
//  JXPOP+String.swift
//  SwiftLession01
//
//  Created by wjx on 2022/2/25.
//

import Foundation
import UIKit

extension String: JXPOPCompatible {}
extension NSString: JXPOPCompatible {}

extension JXPOP where Base: ExpressibleByStringLiteral {
    
    func numberCount() -> Int {
        let string = base as! String
        var count = 0
        for c in string where ("0"..."9").contains(c) {
            count += 1
        }
        return count
    }
}
