//
//  Pusher.swift
//  TPPush-Swift
//
//  Created by Topredator on 2021/8/30.
//

import Foundation

public struct Pusher {
    /// 注册 平台模型
    public static func registerModel(_ model: PlatformWrapper) {
        Manager.shared.pushMode = model
    }
    /// 向 服务器 注册设备token
    public static func registerDeviceToken(_ data: Data) {
        Manager.shared.registerDeviceToken(data)
    }
    /// 设置 通知实现代理
    public static func configNotifyDelegate(_ delegate: PushNotify) {
        Manager.shared.delegate = delegate
    }
    
    /// 获取 第三方平台 通行证 (与自己服务器对接)
    public static func platformPass() -> String? {
        Manager.shared.pushMode?.pass
    }
    
    /// 获取 远程推送信息
    public static var remoteMessage: [AnyHashable: Any]? {
        Manager.shared.remoteNotify
    }
    /// 获取 本地通知信息
    public static var localMessage: [AnyHashable: Any]? {
        Manager.shared.localNotify
    }
    
    /// 取消本地通知
    public static func cancleLocalNotify(_ identify: String?) {
        Manager.shared.cancelLocalNotify(identify)
    }
    /// 取消所有本地通知
    public static func cancleAllLocalNotifies() {
        Manager.shared.cancelAllLocalNotifies()
    }
    
    /// 注册 远程推送服务
    public static func registerRemoteService() {
        Manager.shared.registerRemoteService()
    }
    /// 关闭 远程推送服务
    public static func closeRemoteService() {
        Manager.shared.closeRemoteService()
    }
    
    public static func setupBadge(_ badge: Int) {
        Manager.shared.setBadge(badge)
    }
    
    /// 清除 点击的通知
    public static func emptyRemoteNotifies() {
        Manager.shared.remoteNotify = nil
    }
    public static func emptyLocalNotifies() {
        Manager.shared.localNotify = nil
    }
}
