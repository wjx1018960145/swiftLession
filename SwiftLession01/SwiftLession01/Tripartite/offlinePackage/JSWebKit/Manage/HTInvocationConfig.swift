//
//  HTInvocationConfig.swift
//  SwiftLession01
//
//  Created by wjx on 2022/6/29.
//

import UIKit
import Foundation

class HTInvocationConfig: NSObject {
   
    /**
     *  The methods map
     **/
    var  asyncMethods:Dictionary<String, Any> = Dictionary()
    var syncMethods:Dictionary<String, Any> = Dictionary()
    var name: String = ""
    var clazz: String = ""
    
   
    
    func initWithName(name:String,clazz:String)->Any{
        self.name = name
        self.clazz = clazz
        
        return self
    }
    
    func registerMethods(){
        var  currentClass: AnyClass = NSClassFromString(clazz)! as AnyClass
        
        while currentClass != AnyClass.self {
            let methodCount = UnsafeMutablePointer<UInt32>.allocate(capacity: 0)
           let methodList = class_copyMethodList(object_getClass(currentClass), methodCount)
            let countInt = Int(methodCount[0])
            for i in 0..<countInt {
                let selStr = String(cString:sel_getName(method_getName(methodList![i])))
           var isSyncMethod:Bool
                if selStr.hasPrefix("ht_export_method_sync_") {
                    isSyncMethod = true
                }else if selStr.hasPrefix("ht_export_method_"){
                    isSyncMethod = false
                }else {
                    continue
                }
                let name:String?
                var method:String = ""
                let selector = NSSelectorFromString(selStr);
                if currentClass.responds(to: selector) {
                    method = NSStringFromSelector(selector) //获取方法名
                }
                
                if method.count <= 0 {
                    print("The module class [\(clazz)] doesn't has any method！")
                    continue;
                }
                let nsstr = method as NSString
                let  range = nsstr.range(of: ":")
                if range.location != NSNotFound {
                    name = nsstr.substring(to: range.location) //[method substringToIndex:range.location];
                } else {
                    name = nsstr as String
                }
                var methods:Dictionary = (isSyncMethod ? syncMethods : asyncMethods)
                
                methods[name!] = method
                
//                [methods setObject:method forKey:name];
                
                
        }
            free(methodList);
            currentClass = class_getSuperclass(currentClass)!
    }
    }
    
}
