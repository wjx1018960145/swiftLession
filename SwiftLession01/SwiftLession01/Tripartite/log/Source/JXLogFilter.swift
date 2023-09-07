//
//  JXLogFilter.swift
//  SwiftLession01
//
//  Created by wjx on 2022/6/15.
//

import Foundation

/// Filter the log message
public protocol JXLogFilter {
    
    /// Filter the log object and format message
    /// - Returns: If return true, will ignore the log, if return false, will handle log
    func ignore(log: JXLogEntity, message: String) -> Bool
}
