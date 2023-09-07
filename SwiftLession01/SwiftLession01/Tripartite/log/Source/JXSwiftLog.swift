//
//  JXSwiftLog.swift
//  SwiftLession01
//
//  Created by wjx on 2022/6/15.
//

import Foundation

/// New JXSwiftLog short name
public let JXLogger = JXSwiftLog.default


open class JXSwiftLog{
    
    /// Constants variable
    public struct Constants {
        /// Lib version number
        public static let version = "0.1.2"
        /// Internal console
        public static let internalConsoleIdentifier = "log.internal.console"
        /// Normal console
        public static let normalConsoleIdentifier = "log.normal.console"
        /// File
        public static let fileIdentifier = "log.file"
    }
    
    var logLevel: Level = .debug
    
    public enum Level: Int,CaseIterable{
        case verbose = 0
        case debug = 1
        case info = 2
        case warning = 3
        case error = 4
        
    }
    // MARK: - Property
    
    private var outputs = [JXLogOutput]()
    
    private let semaphore = DispatchSemaphore(value: 1)
    
    private var onlyShowLogFileName: String?
    
    // MARK: - Public
    
    /// Default enable log
    /**
     开启日志 默认是开启的
     */
    public var enable = true
    
    /**
     Customer log format, default is nil
     */
    public var format: String? {
        didSet {
            if self.format != nil {
                JXLogFormatter.shared.formatLog(format!)
            }
        }
    }
    
    /**
     Simple log format
     */
    public static let simpleFormat = "%D -> %F:%l - %f %M"
    
    /// Default instance, developer can alloc it by self
    public static let `default` = JXSwiftLog()
    
    /// Init JJSwiftLog
    /// - Parameter needDefaultOutput: Default output to show lib message log
    public init(needDefaultOutput: Bool = true) {
        if needDefaultOutput {
            let console = JXConsoleOutput(identifier: Constants.internalConsoleIdentifier)
            console.isUseNSLog = false
            console.logLevel = .debug
            self.addLogOutput(console)
        }
    }
    
    /// Simple setup,quick tourist
    /// - Parameters:
    ///   - level: JJSwiftLog.Level, default is debug level
    ///   - fileLevel: JJSwiftLog.Level option type
    ///   - filePath: Save file log `String` path
    open func setup(level: JXSwiftLog.Level = .debug, fileLevel: JXSwiftLog.Level? = nil, filePath: String? = nil) {
        logLevel = level
        
        self.startLogInfo()
        
        let console = JXConsoleOutput(identifier: Constants.normalConsoleIdentifier)
        console.isUseNSLog = false
        console.logLevel = level
        self.addLogOutput(console)
        
        if let file = JXFileOutput(filePath: filePath, delegate: self, identifier: Constants.fileIdentifier) {
            file.logLevel = fileLevel ?? level
            self.addLogOutput(file)
        }
    }

    /// Add customer process log
    /// - Parameter output: JJLogOutput
    public func addLogOutput(_ output: JXLogOutput) {
        semaphore.wait()
        defer {
            semaphore.signal()
        }
        let index = outputs.firstIndex(where: { (out) -> Bool in
            return out == output
        })
        if index == nil {
            outputs.append(output)
        }
    }
    
    /// Remove customer JJLogOutput
    /// - Parameter output: JJLogOutput
    public func removeLogOutput(_ output: JXLogOutput) {
        semaphore.wait()
        defer {
            semaphore.signal()
        }
        let index = outputs.firstIndex(where: { (out) -> Bool in
            return out == output
        })
        if index != nil {
            outputs.remove(at: index!)
        }
    }
    
    /// Process only show log file
    /// - Parameter filename: File name without suffix
    public func onlyLogFile(_ filename: String) {
        onlyShowLogFileName = filename
    }
    
    // MARK: - Log Level
    
    /// Verbose
    /// - Parameter message: message
    @inlinable
    public func verbose(_ message: @autoclosure() -> Any, file: String = #file, function: String = #function, line: Int = #line) {
        custom(level: .verbose, message: message(), file: file, function: function, line: line)
    }
    
    /// Debug
    /// - Parameter message: message
    @inlinable
    public func debug(_ message: @autoclosure() -> Any, file: String = #file, function: String = #function, line: Int = #line) {
        custom(level: .debug, message: message(), file: file, function: function, line: line)
    }
    
    /// Info
    /// - Parameter message: message
    @inlinable
    public func info(_ message: @autoclosure() -> Any, file: String = #file, function: String = #function, line: Int = #line) {
        custom(level: .info, message: message(), file: file, function: function, line: line)
    }
    
    /// Warn
    /// - Parameter message: message
    @inlinable
    public func warning(_ message: @autoclosure() -> Any, file: String = #file, function: String = #function, line: Int = #line) {
        custom(level: .warning, message: message(), file: file, function: function, line: line)
    }
    
    /// Error
    /// - Parameter message: message
    @inlinable
    public func error(_ message: @autoclosure() -> Any, file: String = #file, function: String = #function, line: Int = #line) {
        custom(level: .error, message: message(), file: file, function: function, line: line)
    }
    
    /// Customer log
    /// - Parameter level: level
    /// - Parameter message: message
    /// - Parameter file: file
    /// - Parameter function: function
    /// - Parameter line: line
    public func custom(level: JXSwiftLog.Level, message: Any, file: String = #file, function: String = #function, line: Int = #line) {

        /// Filter onlyShowLogFileName
        if let fileName = onlyShowLogFileName, JXLogOutputConfig.fileNameWithoutSuffix(file) != fileName {
            return
        }
        
        if !enable {
            return
        }
        
        let threadName = self.threadName()
        let resultMessage = "\(message)"
        
        for output in outputs {
            if output.identifier == Constants.internalConsoleIdentifier {
                continue
            }
            if output.logLevel.rawValue > level.rawValue {
                continue
            }
            if let outputQueue = output.queue {
                outputQueue.async {
                    output.log(level, msg: resultMessage, thread: threadName, file: file, function: function, line: line)
                }
            } else {
                output.log(level, msg: resultMessage, thread: threadName, file: file, function: function, line: line)
            }
        }
    }
    
}


extension JXSwiftLog: JXLogOutputDelegate {
    
    public func internalLog(source: JXLogOutput, log: JXLogEntity) {
        internalOutputLog()?.log(log.level, msg: log.message, thread: "", file: log.fileName, function: log.functionName, line: log.lineNumber)
    }
    
}

extension JXSwiftLog {
    
    func internalOutputLog() -> JXLogOutput? {
        for output in outputs where output.identifier == Constants.internalConsoleIdentifier {
            return output
        }
        return nil
    }
    
    func threadName() -> String {
        guard !Thread.isMainThread else {
            return "main"
        }
        
        let threadName = Thread.current.name
        if let threadName = threadName, !threadName.isEmpty {
            return threadName
        } else if let queueName = String(validatingUTF8: __dispatch_queue_get_label(nil)), !queueName.isEmpty {
            return queueName
        } else {
            return String(format: "%p", Thread.current)
        }
    }
    
    /// If add JJLogOutput by manual, developer recommend to call this method
    open func startLogInfo() {

        var buildString = "\(ProcessInfo.processInfo.processName) "
        if let infoDictionary = Bundle.main.infoDictionary {
            if let CFBundleShortVersionString = infoDictionary["CFBundleShortVersionString"] as? String {
                buildString += "Version: \(CFBundleShortVersionString) "
            }
            if let CFBundleVersion = infoDictionary["CFBundleVersion"] as? String {
                buildString += "Build: \(CFBundleVersion) "
            }
        }
        
        let libVersion = JXSwiftLog.Constants.version
        var logs = [String]()
        let appInfo = ">>> \(buildString)PID: \(ProcessInfo.processInfo.processIdentifier)"
        let libInfo = ">>> JJSwiftLog Version: \(libVersion) - Log Level: \(logLevel)"
        logs.append(appInfo)
        logs.append(libInfo)
        
        logs.forEach { message in
            internalOutputLog()?.log(.info, msg: message, thread: "", file: "", function: "", line: 0)
        }
    }
    
}

/// JJSwiftLog short name
@available(*, deprecated, message: "Please replace by JXLogger")
public let jjLogger = JXSwiftLog.self
