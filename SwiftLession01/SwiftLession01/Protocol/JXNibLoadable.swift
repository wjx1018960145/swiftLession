//
//  JKNibLoadable.swift
//  SwiftLession01
//
//  Created by wjx on 2022/2/25.
//

import Foundation
import UIKit
public protocol JXNibLoadable {
}

// MARK: - 一、继承于UIView的才可以使用该协议的扩展
public extension JXNibLoadable where Self: UIView {
    
    // MARK: 1.1、加载xib视图
    /// 加载xib视图
    /// - Parameter nibName: xib名字
    /// - Returns: 返回视图
    static func loadFromNib(_ nibName: String? = nil) -> Self {
        let loadNme = nibName == nil ? "\(self)" : nibName!
        return Bundle.main.loadNibNamed(loadNme, owner: nil, options: nil)?.first as! Self
    }
}
