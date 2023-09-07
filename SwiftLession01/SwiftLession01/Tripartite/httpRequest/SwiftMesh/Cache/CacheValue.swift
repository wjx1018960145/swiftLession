//
//  CacheValue.swift
//  SwiftLession01
//
//  Created by wjx on 2022/6/24.
//

import UIKit
import Foundation
import Alamofire


//// MARK: - Result
public struct CacheValue<Value> {
    public let isCacheData: Bool
    public let result: AFResult<Value>
    public let response: HTTPURLResponse?
    
    init(isCacheData: Bool, result: AFResult<Value>, response: HTTPURLResponse?) {
        self.isCacheData = isCacheData
        self.result = result
        self.response = response
    }
}
