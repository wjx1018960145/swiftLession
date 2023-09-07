//
//  JXLogEntity.swift
//  SwiftLession01
//
//  Created by wjx on 2022/6/15.
//

import Foundation

public struct JXLogEntity {
    
    public var level: JXSwiftLog.Level
    
    public var date: Date
    
    public var message: String
    
    public var functionName:String
    
    public var fileName: String
    
    public var lineNumber: Int
    
    public var extraInfo: [String:Any]
    
    
    
    public init(level: JXSwiftLog.Level,date:Date,message:String,functionName:String,fileName:String,lineNumber:Int,extraInfo:[String:Any] = [:]){
        self.level = level
        self.date = date
        self.message = message
        self.functionName = functionName
        self.fileName = fileName
        self.lineNumber = lineNumber
        self.extraInfo = extraInfo
    }
    
    
}
