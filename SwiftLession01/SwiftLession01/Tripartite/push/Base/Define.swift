//
//  Define.swift
//  TPPush-Swift
//
//  Created by Topredator on 2021/8/30.
//

import Foundation

public extension Notification.Name {
    /// 远程 推送通知
    static let remoteNotify = Notification.Name("com.tp.push.notify.remote")
    /// 本地 通知
    static let localNotify = Notification.Name("com.tp.push.notify.local")
    /// 长链接通知
    static let longConnect = Notification.Name("com.tp.push.notify.longConnect")
}



/// 长链接消息处理
public protocol ConnectMessageHandle: AnyObject {
    func handleLongConnect(_ msg: [AnyHashable: Any]?)
}
public extension ConnectMessageHandle {
    func handleLongConnect(_ msg: [AnyHashable: Any]?) {}
}

/// 第三方平台
public protocol PlatformWrapper: AnyObject {
    /// 初始化
    func register()
    /// 注册设备token
    func registerDeviceToken(_ token: String?)
    /// 处理 远程消息推送
    func handleRemoteNotify(_ param: [AnyHashable: Any]?)
    /// 设置角标
    func setBadge(_ badge: Int)
    /// 平台通行证
    var pass: String? { get }
    /// 平台标识
    var appIdentify: String? { get }
    /// 第三方平台 注册时生成的key
    var appKey: String? { get }
    /// 第三方平台 注册时生成的secret
    var appSecret: String? { get }
    
    var handler: ConnectMessageHandle? { get set }
}

public extension PlatformWrapper {
    func register() {}
    func registerDeviceToken(_ token: String?) {}
    func handleRemoteNotify(_ param: [AnyHashable: Any]?) {}
    func setBadge(_ badge: Int) {}
    var pass: String? { nil }
    var identifier: String? { nil }
    var key: String? { nil }
    var secret: String? { nil }
}

public protocol PushNotify: AnyObject {
    /// 远程推送
    func remoteNotify(_ param: [AnyHashable: Any]?)
    /// 本地通知
    func localNotify(_ param: [AnyHashable: Any]?)
    /// 长链接信息
    func longConnectNotify(_ param: [AnyHashable: Any]?)
}

public extension PushNotify {
    func remoteNotify(_ param: [AnyHashable: Any]?) {}
    func localNotify(_ param: [AnyHashable: Any]?) {}
    func longConnectNotify(_ param: [AnyHashable: Any]?) {}
}
