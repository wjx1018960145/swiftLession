//
//  UISlider+Extension.swift
//  SwiftLession01
//
//  Created by wjx on 2022/2/28.
//

import Foundation
import UIKit

//MARK:- 一、基本的扩展
public extension JXPOP where Base: UISlider {
    
    // MARK: 1.1、UISlider的 闭包事件
    /// UISlider的 闭包事件
    /// - Parameters:
    ///   - controlEvents: 事件类型，默认是 valueChanged
    ///   - sliderCallBack: 闭包
    /// - Returns: 闭包内容
    func setHandle(controlEvents: UIControl.Event = .valueChanged, sliderCallBack: ((Float?) -> ())?) {
        base.swiftCallBack = sliderCallBack
        base.addTarget(base, action: #selector(base.sliderSwitchAction), for: controlEvents)
    }
}

private var sliderCallBackKey: Void?
extension UISlider: JXSwiftPropertyCompatible {
    internal typealias T = Float
    internal var swiftCallBack: SwiftCallBack? {
        get { return jx_getAssociatedObject(self, &sliderCallBackKey) }
        set { jx_setRetainedAssociatedObject(self, &sliderCallBackKey, newValue) }
    }
    
    @objc internal func sliderSwitchAction(_ event: UISlider) {
        self.swiftCallBack?(event.value)
    }
}
