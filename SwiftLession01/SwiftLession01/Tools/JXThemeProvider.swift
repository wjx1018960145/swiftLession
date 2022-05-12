//
//  JXThemeProvider.swift
//  SwiftLession01
//
//  Created by wjx on 2022/5/12.
//
import UIKit
import Foundation
// MARK: - JXThemeProvider协议
public protocol JXThemeProvider: AnyObject {
    func register<Observer: JXThemeable>(observer: Observer)
    func updateTheme()
}

// MARK: - JKThemeable协议
public protocol JXThemeable: AnyObject {
    func apply()
}

// MARK: - 设置遵守UITraitEnvironment的可以使用协议JXThemeable
public extension JXThemeable where Self: UITraitEnvironment {
    var themeProvider: JXThemeProvider {
        return LegacyThemeProvider.shared
    }
}

// MARK: - LegacyThemeProvider
public class LegacyThemeProvider: JXThemeProvider {
    
    /// 单粒
    static let shared = LegacyThemeProvider()
    /// 监听对象数组
    private var observers: NSHashTable<AnyObject> = NSHashTable.weakObjects()
    /// 更新主题
    public func updateTheme() {
        notifyObservers()
    }
    
    // MARK: 注册监听
    /// 注册监听
    /// - Parameter observer: 监听对象
    public func register<Observer: JXThemeable>(observer: Observer) {
        if #available(iOS 13.0, *) {
            return
        }
        self.observers.add(observer)
    }
    
    // MARK: 通知监听对象更新theme
    /// 通知监听对象更新theme
    private func notifyObservers() {
        DispatchQueue.main.async {
            self.observers.allObjects
                .compactMap({ $0 as? JXThemeable })
                .forEach({ $0.apply() })
        }
    }
}

