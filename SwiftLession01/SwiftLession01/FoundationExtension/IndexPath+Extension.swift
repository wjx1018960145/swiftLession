//
//  IndexPath+Extension.swift
//  SwiftLession01
//
//  Created by wjx on 2022/2/24.
//

import Foundation
// MARK: - 一、基本的扩展
public extension IndexPath {
    // MARK: 1.1、 {section, row}
    /// {section, row}
    var string: String {
        return String(format: "{%d, %d}", section, row)
    }
    
    // MARK: 1.2、当前 NSIndexPath 的前一个 NSIndexPath
    /// 当前 NSIndexPath 的前一个 NSIndexPath
    var previousRow: IndexPath {
        if row == 0 {
            return self
        }
        return IndexPath(row: self.row - 1, section: self.section)
    }
    
    // MARK: 1.3、当前 NSIndexPath 的后一个 NSIndexPath
    /// 当前 NSIndexPath 的后一个 NSIndexPath
    var nextRow: IndexPath {
        return IndexPath(row: self.row + 1, section: self.section)
    }
}
