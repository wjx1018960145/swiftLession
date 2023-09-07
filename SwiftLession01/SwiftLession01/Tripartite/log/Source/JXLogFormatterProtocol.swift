//
//  JXLogFormatterProtocol.swift
//  SwiftLession01
//
//  Created by wjx on 2022/6/15.
//

import Foundation

/// Log format protocol
public protocol JXLogFormatterProtocol {
    
    /// Format object to String
    /// - Parameters:
    ///   - log: Origin log object
    ///   - message: Previous formatter result
    /// - Returns: Format string result
    func format(log: JXLogEntity, message: String) -> String
    
    
    
}
