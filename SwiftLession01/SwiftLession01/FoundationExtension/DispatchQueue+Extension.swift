//
//  DispatchQueue+Extension.swift
//  SwiftLession01
//
//  Created by wjx on 2022/2/25.
//

import Foundation
import Foundation
extension DispatchQueue: JXPOPCompatible {}

// MARK: - 一、基本的扩展
public extension JXPOP where Base == DispatchQueue {
    
    private static var _onceTracker = [String]()
    
    // MARK: 1.1、函数只被执行一次
    /// 函数只被执行一次
    /// - Parameters:
    ///   - token: 函数标识
    ///   - block: 执行的闭包
    /// - Returns: 一次性函数
    static func once(token: String, block: () -> ()) {
        if _onceTracker.contains(token) {
            return
        }
        objc_sync_enter(self)
        defer {
            objc_sync_exit(self)
        }
        _onceTracker.append(token)
        block()
    }
}

// MARK: - 二、延迟事件
public extension JXPOP where Base == DispatchQueue {
    // MARK: 2.1、异步做一些任务
    /// 异步做一些任务
    /// - Parameter JKTask: 任务
    @discardableResult
    static func async(_ JXTask: @escaping JXTask) -> DispatchWorkItem {
        return _asyncDelay(0, JXTask)
    }
    
    // MARK: 2.2、异步做任务后回到主线程做任务
    /// 异步做任务后回到主线程做任务
    /// - Parameters:
    ///   - JKTask: 异步任务
    ///   - mainJKTask: 主线程任务
    @discardableResult
    static func async(_ JXTask: @escaping JXTask, _ mainJXTask: @escaping JXTask) -> DispatchWorkItem{
        return _asyncDelay(0, JXTask, mainJXTask)
    }
    
    // MARK: 2.3、异步延迟(子线程执行任务)
    /// 异步延迟(子线程执行任务)
    /// - Parameter seconds: 延迟秒数
    /// - Parameter JKTask: 延迟的block
    @discardableResult
    static func asyncDelay(_ seconds: Double, _ JXTask: @escaping JXTask) -> DispatchWorkItem {
        return _asyncDelay(seconds, JXTask)
    }
    
    // MARK: 2.4、异步延迟回到主线程(子线程执行任务，然后回到主线程执行任务)
    /// 异步延迟回到主线程(子线程执行任务，然后回到主线程执行任务)
    /// - Parameter seconds: 延迟秒数
    /// - Parameter JKTask: 延迟的block
    /// - Parameter mainJKTask: 延迟的主线程block
    @discardableResult
    static func asyncDelay(_ seconds: Double,
                            _ JXTask: @escaping JXTask,
                        _ mainJXTask: @escaping JXTask) -> DispatchWorkItem {
        return _asyncDelay(seconds, JXTask, mainJXTask)
    }
}

// MARK: - 私有的方法
extension JXPOP where Base == DispatchQueue {
    
    /// 延迟任务
    /// - Parameters:
    ///   - seconds: 延迟时间
    ///   - JKTask: 任务
    ///   - mainJKTask: 任务
    /// - Returns: DispatchWorkItem
    fileprivate static func _asyncDelay(_ seconds: Double,
                                         _ JXTask: @escaping JXTask,
                                     _ mainJXTask: JXTask? = nil) -> DispatchWorkItem {
        let item = DispatchWorkItem(block: JXTask)
        DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + seconds, execute: item)
        if let main = mainJXTask {
            item.notify(queue: DispatchQueue.main, execute: main)
        }
        return item
    }
}
