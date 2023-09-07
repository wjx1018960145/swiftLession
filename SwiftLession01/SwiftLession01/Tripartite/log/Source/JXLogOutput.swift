//
//  JXLogOutput.swift
//  SwiftLession01
//
//  Created by wjx on 2022/6/15.
//

import Foundation

internal struct JXLogOutputConfig {
    
    static let padding = " "
    static let dateTimezoneformatter = "yyyy-MM-dd HH:mm:ss.SSSZ"
    static let timeFormatter = "HH:mm:ss"
    static let dateFormatter = "yyyy-MM-dd"
    static let formatDate = DateFormatter()
    static let newline = "\n"
    
    static let point = "."
    
    static func fileNameOfFile(_ file:String)->String {
        let fileParts = file.components(separatedBy: "/")
        if let lastPart = fileParts.last {
            return lastPart
        }
        return ""
    }
    static public func fileNameWithoutSuffix(_ file:String)->String {
        let fileName = fileNameOfFile(file)
        
        if !fileName.isEmpty {
            let fileNameParts = fileName.components(separatedBy: ".")
            if let firstPart = fileNameParts.first {
                return firstPart
            }
        }
        return ""
    }
}

public protocol JXLogOutputDelegate: AnyObject {
    func internalLog(source: JXLogOutput, log: JXLogEntity)
}

public protocol JXLogOutput{
    
    var queue:DispatchQueue?{
        get
    }
    
    func log(_ level: JXSwiftLog.Level, msg: String, thread: String, file: String, function: String, line: Int)
    var logLevel:JXSwiftLog.Level {
        get
        set
    }
    var identifier:String  {
        get
    }
    var delegate: JXLogOutputDelegate? {
       get
        set
    }
    var formatters:[JXLogFormatterProtocol]?{
        get
        set
    }
    var filters: [JXLogFilter]? {
        get
        set
    }
    
    @available(*, deprecated,message: "Use formatters property instead")
    var formatter:JXLogFormatterProtocol? {
        get
        set
    }
    @available(*, deprecated, message: "Use filters property instead")
    var filter: JXLogFilter? {
        get
        set
    }
}

public extension JXLogOutput {
    var identifier: String {
        return String(describing: type(of: self))
    }
}

/// Check JJLogOutput implment object only one
/// - Parameter lhs: JJLogOutput
/// - Parameter rhs: JJLogOutput
func == (lhs: JXLogOutput, rhs: JXLogOutput) -> Bool {
    return lhs.identifier == rhs.identifier
}
