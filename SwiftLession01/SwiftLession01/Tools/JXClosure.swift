//
//  JXClosure.swift
//  SwiftLession01
//
//  Created by wjx on 2022/2/25.
//

import Foundation
import UIKit
 //view的闭包
public typealias ViewClosure = ((UITapGestureRecognizer?,UIView,NSInteger)->Void)
//手势的闭包
public typealias RecognizerClosure = ((UIGestureRecognizer)->Void)
//UIControl闭包
public typealias ControlClosure = ((UIControl)->Void)

