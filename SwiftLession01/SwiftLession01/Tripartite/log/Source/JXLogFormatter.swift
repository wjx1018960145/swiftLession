//
//  JXLogFormatter.swift
//  SwiftLession01
//
//  Created by wjx on 2022/6/15.
//

import Foundation
/// Formatter option
public enum FormatterOption: String {
    // Text message
    case message = "M"
    // Log level
    case level = "L"
    // Log number
    case line = "l"
    // Log file name(without extension)
    case file = "F"
    // Log function
    case function = "f"
    // Date, format: yyyy-MM-dd HH:mm:ss.SSSZ
    case date = "D"
    // Only Date, format: yyyy-MM-dd
    case onlyDate = "d"
    // Only Time, format: HH:mm:ss
    case time = "t"
    // Thread name
    case thread = "T"
    // Origin text
    case origin = "origin"
    // Ignore text
    case ignore = "I"
    // Log file name with extension
    case fileExtension = "N"
}
public enum LogSegment {
    case token(FormatterOption,String)
}
public final class JXLogFormatter {
    
    public static let shared: JXLogFormatter = {
        let format  = JXLogFormatter()
        return format
    }()
    
    private init(){
        
    }
    
    lazy public var segments = {
        return [LogSegment]()
    }()
    
    func formatLog(_ formatter:String){
        if(formatter.isEmpty){
            return
        }
        self.segments.removeAll()
        let phrases = ("%I"+formatter).components(separatedBy: "%")
        
        for phrase in phrases where !phrase.isEmpty {
            let (_,offset) = self.parsePadding(phrase)
            let formatCharIndex = phrase.index(phrase.startIndex, offsetBy: offset)
            let formatChar = phrase[formatCharIndex]
            let rangeAfterFormatChar = phrase.index(formatCharIndex, offsetBy: 1)..<phrase.endIndex
            let remainingPhrase = phrase[rangeAfterFormatChar]
            let formatSegment = FormatterOption(rawValue: String(formatChar))
            
            switch formatSegment {
            case .message, .date, .level, .ignore, .thread, .line, .file, .function, .onlyDate, .time, .fileExtension:
                segments.append(.token(formatSegment!, String(remainingPhrase)))
            case .origin:
                segments.append(.token(.origin, phrase))
            default:
                segments.append(.token(.origin, phrase))
            }
            
        }
    }
    
    func parsePadding(_ text: String) -> (Int, Int) {
        let sign: Int = 1
        
        let numString = text.prefix { $0 >= "0" && $0 <= "9" }
        if let num = Int(String(numString)) {
            return (sign * num, (sign == -1 ? 1 : 0) + numString.count)
        } else {
            return (0, 0)
        }
    }
}
