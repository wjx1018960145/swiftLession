//
//  HTSessionConfiguration.swift
//  SwiftLession01
//
//  Created by wjx on 2022/7/4.
//

import UIKit
/***********************
 将NSURLSessionConfiguration的属性protocolClasses的get方法hook掉，通过返回我们自己的protocol，这样，我们就能够监控到通过sessionWithConfiguration:delegate:delegateQueue:得到的session的网络请求
 ***********************/

class HTSessionConfiguration: NSObject {
    // MARK: - 外部属性
    var isSwizzle: Bool = false
    
    // MARK: - 单例模式
    private static let share = HTSessionConfiguration()
    public static func defaultCenter() -> HTSessionConfiguration {
        return HTSessionConfiguration.share
    }
    
    private override init() {
        print("PKHSessionConfiguration被初始化一次")
    }
    
    // MARK: - Method
    func load() {
        isSwizzle = true
        guard let cls = NSClassFromString("__NSCFURLSessionConfiguration") ?? NSClassFromString("NSURLSessionConfiguration") else { return  }
        swizzle(#selector(protocolClasses), from: cls, to: HTSessionConfiguration.self)
    }
    
    func unload() {
        isSwizzle = false
        guard let cls = NSClassFromString("__NSCFURLSessionConfiguration") ?? NSClassFromString("NSURLSessionConfiguration") else { return  }
        swizzle(#selector(protocolClasses), from: cls, to: HTSessionConfiguration.self)
    }
    
    func swizzle(_ selector: Selector, from original: AnyClass, to stub: AnyClass) {
        let originalMethod = class_getInstanceMethod(original, selector)
        let stubMethod = class_getInstanceMethod(stub, selector)
        //        #if false
        //        if originalMethod == nil || stubMethod == nil {
        //            NSException.raise(NSExceptionName.internalInconsistencyException, format: "Couldn't load NEURLSessionConfiguration.")
        //        }
        //        #endif
        if let originalMethod = originalMethod, let stubMethod = stubMethod {
            method_exchangeImplementations(originalMethod, stubMethod)
        }
    }
    
    @objc func protocolClasses() -> Array<AnyClass>{
        // 如果还有其他的监控protocol，也可以在这里加进去
        return [HTSessionConfiguration.self]
    }
}
