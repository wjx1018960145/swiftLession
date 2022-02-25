//
//  UInt+Extension.swift
//  SwiftLession01
//
//  Created by wjx on 2022/2/22.
//

import UIKit
extension UInt: JXPOPCompatible {}
// MARK: - 一、UInt 与其他类型的转换
public extension JXPOP where Base == UInt {
    // MARK: 1.1、转 Int
    /// 转 Int
    var uintToInt: Int { return Int(self.base) }
}
