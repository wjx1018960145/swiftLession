//
//  JXCommonTool.swift
//  SwiftLession01
//
//  Created by wjx on 2022/2/25.
//

import Foundation
import UIKit

public struct JXCommonTool {
    
    // MARK: 1.1、交换两个值
    /// 交换两个值
    /// - Parameters:
    ///   - value1: 值一
    ///   - value2: 值二
    ///
    @discardableResult
    public static func swapMe<T>(value1:inout T,value2:inout T)->(T,T) {
        (value1,value2) = (value2,value1)
        return (value1, value2)
    }
}

