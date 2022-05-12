//
//  JXDarkModeUtil.swift
//  SwiftLession01
//
//  Created by wjx on 2022/5/12.
//
/*
 默认开启：跟随系统模式
 
 1、跟随系统
 1.1、需要设置：
 UIApplication.shared.windows.filter({$0.isKeyWindow}).first?.overrideUserInterfaceStyle = .unspecified
 2、不跟随系统
 2.1、浅色，UIApplication.shared.windows.filter({$0.isKeyWindow}).first?.overrideUserInterfaceStyle = .light
 2.2、深色，UIApplication.shared.windows.filter({$0.isKeyWindow}).first?.overrideUserInterfaceStyle = .dark
 */
import Foundation
import UIKit
public class JXDarkModeUtil {
    /// 智能换肤的时间区间的key
    private static let JXSmartPeelingTimeIntervalKey = "JXSmartPeelingTimeIntervalKey"
    /// 跟随系统的key
    private static let JXDarkToSystemKey = "JXDarkToSystemKey"
    /// 是否浅色模式的key
    private static let JXLightDarkKey = "JXLightDarkKey"
    /// 智能换肤的key
    private static let JXSmartPeelingKey = "JXSmartPeelingKey"
    /// 是否浅色
    public static var isLight: Bool {
        if isSmartPeeling {
            return isSmartPeelingTime() ? false : true
        }
        if let value = UserDefaults.jx.userDefaultsGetValue(key: JXLightDarkKey) as? Bool {
            return value
        }
        return true
    }
    /// 是否跟随系统
    public static var isFollowSystem: Bool {
        if #available(iOS 13, *) {
            if let value = UserDefaults.jx.userDefaultsGetValue(key: JXDarkToSystemKey) as? Bool {
                return value
            }
            return true
        }
        return false
    }
    /// 默认不是智能换肤
    public static var isSmartPeeling: Bool {
        if let value = UserDefaults.jx.userDefaultsGetValue(key: JXSmartPeelingKey) as? Bool {
            return value
        }
        return false
    }
    /// 智能换肤的时间段：默认是：21:00~8:00
    public static var SmartPeelingTimeIntervalValue: String {
        get {
            if let value = UserDefaults.jx.userDefaultsGetValue(key: JXSmartPeelingTimeIntervalKey) as? String {
                return value
            }
            return "21:00~8:00"
        }
        set {
            UserDefaults.jx.userDefaultsSetValue(value: newValue, key: JXSmartPeelingTimeIntervalKey)
        }
    }
}

// MARK: - 方法的调用
extension JXDarkModeUtil: JXThemeable {
    public func apply() {}
}

public extension JXDarkModeUtil {
    
    // MARK: 初始化的调用
    /// 默认设置
    static func defaultDark() {
        if #available(iOS 13.0, *) {
            // 默认跟随系统暗黑模式开启监听
            if (JXDarkModeUtil.isFollowSystem) {
                JXDarkModeUtil.setDarkModeFollowSystem(isFollowSystem: true)
            } else {
                UIApplication.shared.windows.filter({$0.isKeyWindow}).first?.overrideUserInterfaceStyle = JXDarkModeUtil.isLight ? .light : .dark
            }
        }
    }
    
    // MARK: 设置系统是否跟随
    static func setDarkModeFollowSystem(isFollowSystem: Bool) {
        if #available(iOS 13.0, *) {
            // 1.1、设置是否跟随系统
            UserDefaults.jx.userDefaultsSetValue(value: isFollowSystem, key: JXDarkToSystemKey)
            let result = UITraitCollection.current.userInterfaceStyle == .light ? true : false
            UserDefaults.jx.userDefaultsSetValue(value: result, key: JXLightDarkKey)
            UserDefaults.jx.userDefaultsSetValue(value: false, key: JXSmartPeelingKey)
            // 1.2、设置模式的保存
            if isFollowSystem {
                UIApplication.shared.windows.filter({$0.isKeyWindow}).first?.overrideUserInterfaceStyle = .unspecified
            } else {
                UIApplication.shared.windows.filter({$0.isKeyWindow}).first?.overrideUserInterfaceStyle = UITraitCollection.current.userInterfaceStyle
            }
        }
    }
    
    // MARK: 设置：浅色 / 深色
    static func setDarkModeCustom(isLight: Bool) {
        if #available(iOS 13.0, *) {
            // 1.1、只要设置了模式：就是黑或者白
            UIApplication.shared.windows.filter({$0.isKeyWindow}).first?.overrideUserInterfaceStyle = isLight ? .light : .dark
            // 1.2、设置跟随系统和智能换肤：否
            UserDefaults.jx.userDefaultsSetValue(value: false, key: JXDarkToSystemKey)
            UserDefaults.jx.userDefaultsSetValue(value: false, key: JXSmartPeelingKey)
            // 1.3、黑白模式的设置
            UserDefaults.jx.userDefaultsSetValue(value: isLight, key: JXLightDarkKey)
        } else {
            UserDefaults.jx.userDefaultsSetValue(value: false, key: JXSmartPeelingKey)
            // 模式存储
            UserDefaults.jx.userDefaultsSetValue(value: isLight, key: JXLightDarkKey)
            // 通知模式更新
            LegacyThemeProvider.shared.updateTheme()
        }
    }
    
    // MARK: 设置：智能换肤
    /// 智能换肤
    /// - Parameter isSmartPeeling: 是否智能换肤
    static func setSmartPeelingDarkMode(isSmartPeeling: Bool) {
        if #available(iOS 13.0, *) {
            // 1.1、设置智能换肤
            UserDefaults.jx.userDefaultsSetValue(value: isSmartPeeling, key: JXSmartPeelingKey)
            // 1.2、智能换肤根据时间段来设置：黑或者白
            UIApplication.shared.windows.filter({$0.isKeyWindow}).first?.overrideUserInterfaceStyle = isLight ? .light : .dark
            // 1.3、设置跟随系统：否
            UserDefaults.jx.userDefaultsSetValue(value: false, key: JXDarkToSystemKey)
            UserDefaults.jx.userDefaultsSetValue(value: isLight, key: JXLightDarkKey)
        } else {
            // 模式存储
            // 1.1、设置智能换肤
            UserDefaults.jx.userDefaultsSetValue(value: isSmartPeeling, key: JXSmartPeelingKey)
            // 1.2、设置跟随系统：否
            UserDefaults.jx.userDefaultsSetValue(value: isLight, key: JXLightDarkKey)
            // 1.3、通知模式更新
            LegacyThemeProvider.shared.updateTheme()
        }
    }
    
    // MARK: 智能换肤时间选择后
    /// 智能换肤时间选择后
    static func setSmartPeelingTimeChange(startTime: String, endTime: String) {
        
        /// 是否是浅色
        var light: Bool = false
        if JXDarkModeUtil.isSmartPeelingTime(startTime: startTime, endTime: endTime), JXDarkModeUtil.isLight {
            light = false
        } else {
            if !JXDarkModeUtil.isLight {
                light = true
            } else {
                JXDarkModeUtil.SmartPeelingTimeIntervalValue = startTime + "~" + endTime
                return
            }
        }
        JXDarkModeUtil.SmartPeelingTimeIntervalValue = startTime + "~" + endTime
        
        if #available(iOS 13.0, *) {
            // 1.1、只要设置了模式：就是黑或者白
            UIApplication.shared.windows.filter({$0.isKeyWindow}).first?.overrideUserInterfaceStyle = light ? .light : .dark
            // 1.2、黑白模式的设置
            UserDefaults.jx.userDefaultsSetValue(value: light, key: JXLightDarkKey)
        } else {
            // 模式存储
            UserDefaults.jx.userDefaultsSetValue(value: light, key: JXLightDarkKey)
            // 通知模式更新
            LegacyThemeProvider.shared.updateTheme()
        }
    }
}

// MARK: - 动态颜色的使用
public extension JXDarkModeUtil {
    static func colorLightDark(lightColor: UIColor, darkColor: UIColor) -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor { (traitCollection) -> UIColor in
                if JXDarkModeUtil.isFollowSystem {
                    if traitCollection.userInterfaceStyle == .light {
                        return lightColor
                    } else {
                        return darkColor
                    }
                } else if JXDarkModeUtil.isSmartPeeling {
                    return isSmartPeelingTime() ? darkColor : lightColor
                } else {
                    return JXDarkModeUtil.isLight ? lightColor : darkColor
                }
            }
        } else {
            // iOS 13 以下主题色的使用
            if JXDarkModeUtil.isLight {
                return lightColor
            }
            return darkColor
        }
    }
    
    // MARK: 是否为智能换肤的时间：黑色
    /// 是否为智能换肤的时间：黑色
    /// - Returns: 结果
    static func isSmartPeelingTime(startTime: String? = nil, endTime: String? = nil) -> Bool {
        // 获取暗黑模式时间的区间，转为两个时间戳，取出当前的时间戳，看是否在区间内，在的话：黑色，否则白色
        var timeIntervalValue: [String] = []
        if startTime != nil && endTime != nil {
            timeIntervalValue = [startTime!, endTime!]
        } else {
            timeIntervalValue = JXDarkModeUtil.SmartPeelingTimeIntervalValue.jx.separatedByString(with: "~") as! [String]
        }
        // 1、时间区间分隔为：开始时间 和 结束时间
        // 2、当前的时间转时间戳
        let currentDate = Date()
        let currentTimeStamp = Int(currentDate.jx.dateToTimeStamp())!
        let dateString = currentDate.jx.toformatterTimeString(formatter: "yyyy-MM-dd")
        let startTimeStamp = Int(Date.jx.formatterTimeStringToTimestamp(timesString: dateString + " " + timeIntervalValue[0], formatter: "yyyy-MM-dd HH:mm", timestampType: .second))!
        var endTimeStamp = Int(Date.jx.formatterTimeStringToTimestamp(timesString: dateString + " " + timeIntervalValue[1], formatter: "yyyy-MM-dd HH:mm", timestampType: .second))!
        if startTimeStamp > endTimeStamp {
            endTimeStamp = endTimeStamp + 884600
        }
        return currentTimeStamp >= startTimeStamp && currentTimeStamp <= endTimeStamp
    }
}

// MARK: - 动态图片的使用
public extension JXDarkModeUtil {

    // MARK: 深色图片和浅色图片切换 （深色模式适配）
    /// 深色图片和浅色图片切换 （深色模式适配）
    /// - Parameters:
    ///   - light: 浅色图片
    ///   - dark: 深色图片
    /// - Returns: 最终图片
    static func image(light: UIImage?, dark: UIImage?) -> UIImage? {
        if #available(iOS 13.0, *) {
            guard let weakLight = light, let weakDark = dark, let config = weakLight.configuration else { return light }
            let lightImage = weakLight.withConfiguration(config.withTraitCollection(UITraitCollection(userInterfaceStyle: UIUserInterfaceStyle.light)))
            lightImage.imageAsset?.register(weakDark, with: config.withTraitCollection(UITraitCollection(userInterfaceStyle: UIUserInterfaceStyle.dark)))
            return lightImage.imageAsset?.image(with: UITraitCollection.current) ?? light
        } else {
            // iOS 13 以下主题色的使用
            if JXDarkModeUtil.isLight {
                return light
            }
            return dark
        }
    }
}
