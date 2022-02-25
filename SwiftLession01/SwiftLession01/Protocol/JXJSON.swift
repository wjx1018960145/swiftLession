//
//  JXJSON.swift
//  SwiftLession01
//
//  Created by wjx on 2022/2/24.
//

import Foundation
// MARK: - 自定义一个JSON协议
public protocol JXJSON: Codable {
    func toJSONString() -> String?
}
 
// MARK: - 扩展协议方法
public extension JXJSON {
    // MARK: 将数据转成可用的JSON模型
    func toJSONString() -> String? {
        // encoded对象
        if let encodedData = try? JSONEncoder().encode(self) {
            // 从encoded对象获取String
            return String(data: encodedData, encoding: .utf8)
        }
        return nil
    }
}
