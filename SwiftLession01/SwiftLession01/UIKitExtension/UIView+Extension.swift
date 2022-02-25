//
//  UIView+Extension.swift
//  SwiftLession01
//
//  Created by wjx on 2022/2/21.
//

import UIKit
import Foundation
import CoreFoundation
import WebKit
public enum JXDashLineDirection: Int {
    case vertical = 0
    case horizontal = 1
}

extension UIView: JXPOPCompatible {}
// MARK: - 一、机型的判断
/*
 iphone硬件型号
 iPhoneX的分辨率：      2436 * 1125 || pt: 812 * 375
 iPhoneXR的分辨率：     1792 * 828 || pt: 896 * 414
 iPhoneXS的分辨率：     2436 * 1125 || pt: 812 * 375
 iPhoneXS Max的分辨率： 2688 * 1242 || pt: 896 * 414
 */
let isIPhone4 = (CGSize(width: 640, height: 960).equalTo(UIScreen.main.currentMode!.size))
let isIPhone5 = (CGSize(width: 640, height: 1136).equalTo(UIScreen.main.currentMode!.size))
let isIPhone6 = (CGSize(width: 750, height: 1334).equalTo(UIScreen.main.currentMode!.size))
let isIPhone6P = (CGSize(width: 1242, height: 2208).equalTo(UIScreen.main.currentMode!.size))
let isIPhoneX = UIScreen.main.bounds.height >= 812
let isIPhoneXR = (CGSize(width: 828, height: 1792).equalTo(UIScreen.main.currentMode!.size))
let isIPhoneXS = (CGSize(width: 1125, height: 2436).equalTo(UIScreen.main.currentMode!.size))
let isIiPhoneXSMax = (CGSize(width: 1242, height: 2688).equalTo(UIScreen.main.currentMode!.size))

// MARK: 1.1、设备型号
/// 设备型号
/// - Returns: 设备型号信息
public func jx_deviceModel() -> String {
    var systemInfo = utsname()
    uname(&systemInfo)
    let size = Int(_SYS_NAMELEN)
    let deviceModelName = withUnsafeMutablePointer(to: &systemInfo.machine) { p in
        p.withMemoryRebound(to: CChar.self, capacity: size, { p2 in
            return String(cString: p2)
        })
    }
    return deviceModelName
}

// MARK: 1.2、是不是 iPhone X
/// 是不是 iPhone X
/// - Returns: bool
public func jx_isIphoneX() -> Bool {
    return jx_isIphone() && jx_kScreenH == 812
}

// MARK: 1.3、是不是 iPhone XS
/// 是不是 iPhone XS
/// - Returns: description
public func jx_isXs() -> Bool {
    return jx_isIphone() && jx_kScreenH == 812
}

// MARK: 1.4、是不是 iPhone XR
/// 是不是 iPhone XR
/// - Returns: description
public func jx_isXR() -> Bool {
    return jx_isIphone() && jx_kScreenH == 896 && jx_kScreenW == 414
}

// MARK: 1.5、是不是 iPhone XsMax
/// 是不是 iPhone XsMax
/// - Returns: description
public func jx_isXsMax() -> Bool {
    return jx_isIphone() && jx_kScreenH == 896 && jx_kScreenW == 414
}

// MARK: 1.6、是不是 iPhone
/// 判断是不是 iPhone
/// - Returns: bool
public func jx_isIphone() -> Bool {
    return UI_USER_INTERFACE_IDIOM() == .phone
}

// MARK: 1.7、判断是否是 pad
/// 判断是否是 pad
/// - Returns: bool
public func jx_isPadDevice() -> Bool {
    return UI_USER_INTERFACE_IDIOM() == .pad
}

// MARK: 1.8、判断是不是 4 4s
/// 4 4s
/// - Returns: description
public func jx_is4OrLess() -> Bool {
    return jx_isIphone() && jx_kScreenH < 568
}

// MARK: 1.9、判断是不是 5 5c 5s
/// 判断是不是 5 5c 5s
/// - Returns: description
public func jx_is5() -> Bool {
    return jx_isIphone() && jx_kScreenH == 568
}

// MARK: 1.10、判断是不是 6 6s 7 8
/// 判断是不是 6 6s 7 8
/// - Returns: description
public func jx_is678() -> Bool {
    return jx_isIphone() && jx_kScreenH == 667
}

// MARK: 1.11、判断是不是 6p 7p 8p
/// 判断是不是 6p 7p 8p
/// - Returns: description
public func jx_is678P() -> Bool {
    return jx_isIphone() && jx_kScreenH == 736
}

// MARK: 1.12、当前设备是不是模拟器
/// 当前设备是不是模拟器
/// - Returns: result
public func jx_isSimulator() -> Bool {
    var isSim = false
    #if arch(i386) || arch(x86_64)
    isSim = true
    #endif
    return isSim
//    return UIDevice.jx.isSimulator()
}

// MARK: - 二、屏幕尺寸常用的常量
// MARK: 2.1、屏幕的宽
/// 屏幕的宽
public let jx_kScreenW: CGFloat = UIScreen.main.bounds.width
// MARK: 2.2、屏幕的高
/// 屏幕的高
public let jx_kScreenH: CGFloat = UIScreen.main.bounds.height
// MARK: 2.3、获取statusBar的高度
/// 获取statusBar的高度
public var jx_kStatusBarFrameH: CGFloat {
    guard isIPhoneX else {
        return 20
    }
    // 防止界面没有出来获取为0的情况
    return UIApplication.shared.statusBarFrame.height > 0 ? UIApplication.shared.statusBarFrame.height : 44
}
// MARK: 2.4、获取导航栏的高度
/// 获取导航栏的高度
public let jx_kNavFrameH: CGFloat = 44 + jx_kStatusBarFrameH
    
// MARK: 2.5、屏幕底部Tabbar高度
/// 屏幕底部Tabbar高度
public var jx_kTabbarFrameH: CGFloat { return isIPhoneX ? 83 : 49 }
// MARK: 2.6、屏幕底部刘海高度
/// 屏幕底部刘海高度
public var jx_kTabbarBottom: CGFloat { return isIPhoneX ? 34 : 0 }
// MARK: 2.7、屏幕比例
/// 屏幕比例
public let jx_kPixel = 1.0 / UIScreen.main.scale
// MARK: 2.8、身份证宽高比
/// 身份证宽高比
public let jx_kRatioIDCard: CGFloat = 0.63
// MARK: 2.9、适配比例
/// 适配比例
public let jx_scaleIphone = jx_kScreenW / CGFloat(375.0)

// MARK: - 屏幕16:9比例系数下的宽高
// 宽
public let jx_kScreenW16_9: CGFloat = jx_kScreenW * 9.0 / 16.0
// 高
public let jx_kScreenH16_9: CGFloat = jx_kScreenH * 16.0 / 9.0
// MARK: - 三、UIView 有关 Frame 的扩展
public extension JXPOP where Base: UIView {
    
    // MARK: 3.3、height: 视图的高度
    /// height: 视图的高度
    var height: CGFloat {
        get {
            return base.frame.size.height
        }
        set(newValue) {
            var tempFrame: CGRect = base.frame
            tempFrame.size.height = newValue
            base.frame = tempFrame
        }
    }
    
    // MARK: 3.4、width: 视图的宽度
    /// width: 视图的宽度
    var width: CGFloat {
        get {
            return base.frame.size.width
        }
        set(newValue) {
            var tempFrame: CGRect = base.frame
            tempFrame.size.width = newValue
            base.frame = tempFrame
        }
    }
}
