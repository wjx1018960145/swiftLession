//
//  JXJSON.swift
//  SwiftLession01
//
//  Created by wjx on 2022/2/10.
//

import Foundation
// 自顶一个一个JSON协议
public protocol JXJSON :Codable {
    
    func toJSONString()->String?
    
}
//扩展协议方法
public extension JXJSON {
    func toJSONString()->String? {
        if let encodedData = try? JSONEncoder().encode(self){
            return String(data: encodedData, encoding: .utf8)
        }
         return nil
    }
    
}
