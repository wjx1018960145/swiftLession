//
//  JXLogOutput+Extension.swift
//  SwiftLession01
//
//  Created by wjx on 2022/6/15.
//

import Foundation

/// Extension for JJSwiftLog.Level
extension JXSwiftLog.Level {

    /// String level
    public var stringLevel: String {
        switch self {
        case .verbose:
            return "VERBOSE"
        case .debug:
            return "DEBUG"
        case .info:
            return "INFO"
        case .warning:
            return "WARN"
        case .error:
            return "ERROR"
        }
    }

    /// Emoji level
    public var emojiLevel: String {
        switch self {
        case .verbose:
            return "📗"
        case .debug:
            return "📘"
        case .info:
            return "📓"
        case .warning:
            return "📙"
        case .error:
            return "📕"
        }
    }
    
}

extension JXLogOutput {
    
    /// Generate log from log level,thread,file name,function line number
    /// - Parameter level: log level
    /// - Parameter msg: text
    /// - Parameter thread: thread
    /// - Parameter file: file name
    /// - Parameter function: function
    /// - Parameter line: line number
    func formatMessage(level: JXSwiftLog.Level, msg: String, thread: String,
                       file: String, function: String, line: Int) -> String {
        if !JXLogFormatter.shared.segments.isEmpty {
            return formatSegmentMessage(level: level, msg: msg, thread: thread, file: file, function: function, line: line)
        }
        var text = ""
        text += self.formatDate(JXLogOutputConfig.dateTimezoneformatter) + JXLogOutputConfig.padding
        text += level.emojiLevel + JXLogOutputConfig.padding
        text += thread.isEmpty ? "" : (thread + JXLogOutputConfig.padding)
        if !file.isEmpty {
            text += JXLogOutputConfig.fileNameWithoutSuffix(file)  + JXLogOutputConfig.point
        }
        if !function.isEmpty {
            text += function + JXLogOutputConfig.padding
        }
        if line != 0 {
            text += "\(line)" + JXLogOutputConfig.padding
        }
        text += level.stringLevel + JXLogOutputConfig.padding
        text += msg
        text += JXLogOutputConfig.newline
        return text
    }

    /// Format segment message
    /// - Parameters:
    ///   - level: Log level
    ///   - msg: Text message
    ///   - thread: Thread name
    ///   - file: File name, suffix extension
    ///   - function: Function
    ///   - line: Function line number
    /// - Returns: All info string
    func formatSegmentMessage(level: JXSwiftLog.Level, msg: String, thread: String,
                              file: String, function: String, line: Int) -> String {
        var text = ""
        let segments = JXLogFormatter.shared.segments
        for segment in segments {
            switch segment {
            case .token(let option, let string):
                switch option {
                case .message:
                    text += (msg + string)
                case .level:
                    text += (level.stringLevel + string)
                case .line:
                    text += ("\(line)" + string)
                case .file:
                    text += (JXLogOutputConfig.fileNameWithoutSuffix(file) + string)
                case .fileExtension:
                    text += (JXLogOutputConfig.fileNameOfFile(file) + string)
                case .function:
                    text += (function + string)
                case .date:
                    text += (self.formatDate(JXLogOutputConfig.dateTimezoneformatter) + string)
                case .onlyDate:
                    text += (self.formatDate(JXLogOutputConfig.dateFormatter) + string)
                case .time:
                    text += (self.formatDate(JXLogOutputConfig.timeFormatter) + string)
                case .thread:
                    text += thread.isEmpty ? "" : thread
                case .origin:
                    text += string
                case .ignore:
                    text += string
                }
            }
        }
        text += JXLogOutputConfig.newline
        return text
    }
    
    /// Format date
    /// - Parameter dateFormat: Date format
    /// - Parameter timeZone: timeZone
    func formatDate(_ dateFormat: String, timeZone: String = "") -> String {
        
        if !timeZone.isEmpty {
            JXLogOutputConfig.formatDate.timeZone = TimeZone(abbreviation: timeZone)
        }
        JXLogOutputConfig.formatDate.dateFormat = dateFormat
        let dateStr = JXLogOutputConfig.formatDate.string(from: Date())
        return dateStr
    }
    
    /// Write string to filepointer
    /// - Parameter string: string
    /// - Parameter filePointer: UnsafeMutablePointer<FILE>
    func writeStringToFile(_ string: String, filePointer: UnsafeMutablePointer<FILE>) {
        string.withCString { ptr in
            
            #if os(Windows)
             _lock_file(filePointer)
             #else
             flockfile(filePointer)
             #endif
            defer {
                #if os(Windows)
                _unlock_file(filePointer)
                #else
                funlockfile(filePointer)
                #endif
            }
            
            _ = fputs(ptr, filePointer)
            _ = fflush(filePointer)
        }
    }
}
