//
//  Data+extension.swift
//  SwiftLession01
//
//  Created by wjx on 2022/3/2.
//

import Foundation
import UIKit
extension Data: JXPOPCompatible {}
// MARK: - 一、基本的扩展
public extension JXPOP where Base == Data {

    // MARK: 1.1、base64编码成 Data
    /// 编码
    var encodeToData: Data? {
        return self.base.base64EncodedData()
    }
    
    // MARK: 1.2、base64解码成 Data
    /// 解码成 Data
    var decodeToDada: Data? {
        return Data(base64Encoded: self.base)
    }
    
    // MARK: 1.3、转成bytes
    /// 转成bytes
    var bytes: [UInt8] {
        return [UInt8](self.base)
    }
    
}
