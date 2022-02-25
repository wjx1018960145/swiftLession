//
//  Range+Extension.swift
//  SwiftLession01
//
//  Created by wjx on 2022/2/25.
//

import Foundation
// MARK: - 一、基本的扩展
extension Range: JXPOPCompatible {}

public extension JXPOP where Base: RangeExpression, Base.Bound == String.Index {
    
    // MARK: 1.1、Range 转 NSRange
    /// Range 转 NSRange
    /// - Parameter string: 父字符串
    /// - Returns: NSRange
    func toNSRange<S: StringProtocol>(in string: S) -> NSRange {
        return NSRange(self.base, in: string)
    }
}
