//
//  Bool+Extension.swift
//  SwiftLession01
//
//  Created by wjx on 2022/2/22.
//

import Foundation
import UIKit
extension Bool: JXPOPCompatible {}
// MARK: - 一、基本的扩展
public extension JXPOP where Base == Bool {
 
    // MARK: 1.1、Bool 值转 Int
    /// Bool 值转 Int
    var boolToInt: Int { return self.base ? 1 : 0 }
}
