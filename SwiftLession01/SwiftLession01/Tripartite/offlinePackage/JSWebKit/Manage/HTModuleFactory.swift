//
//  HTModuleFactory.swift
//  SwiftLession01
//
//  Created by wjx on 2022/6/29.
//

import UIKit

class HTModuleConfig:HTInvocationConfig {
    
}

class HTModuleFactory: NSObject {
    
    static var sharedInstance = HTModuleFactory()
    
    var moduleMap:Dictionary<String, Any>?
    var moduleLock:NSLock

    // WebView 的ViewController
    var  containerViewController:UIViewController?
    
    
    override init() {
        moduleMap = Dictionary()
        moduleLock = NSLock()
    }
    
    /**
     * @abstract Returns the class of specific module
     *
     * @param name The module name
     *
     **/
    static func classWithModuleName(name:String)->AnyClass{
        var config:HTModuleConfig?
        sharedInstance.moduleLock.lock()
        config = (sharedInstance.moduleMap![name] as! HTModuleConfig)
        sharedInstance.moduleLock.unlock()
        
        return NSClassFromString(config!.clazz)!
        }
    
    /**
     * @abstract Registers a module for a given name and the implemented class
     *
     * @param name The module name to register
     *
     * @param clazz The module class to register
     *
     **/
   static func registerModule(name:String,clazz:AnyClass)->String{
       sharedInstance.moduleLock.lock()
       //allow to register module with the same name;
       let config = HTModuleConfig()
       config.name = name
       config.clazz = NSStringFromClass(clazz)
       config.registerMethods()
       sharedInstance.moduleMap![name] = config
//       [_moduleMap setValue:config forKey:name];
       sharedInstance.moduleLock.unlock()
        return name
    }
    
    /**
     * @abstract Returns the export methods in the specific module
     *
     * @param name The module name
     **/
    static func moduleMethodMapsWithName(name:String)->Dictionary<String, Any>{
        var dict = Dictionary<String, Any>()
        var methods:Array<Any> = sharedInstance.defaultModuleMethod()
        
        sharedInstance.moduleLock.lock()
        dict[name] = methods
//        [dict setValue:methods forKey:name];
        
       let  config = (sharedInstance.moduleMap![name] as! HTModuleConfig)
//        let mBlock:@convention(block)(_ mKey:Any,_ mObj:Any, _ mStop:Bool)->() = {mKey,mObj,mStop in
//
//            methods.append(mKey)
//        }
//        void (^mBlock)(id, id, BOOL *) = ^(id mKey, id mObj, BOOL * mStop) {
//            [methods addObject:mKey];
//        };
        //遍历字典讲字典的key放到方法数组中
        for (_, value) in config.syncMethods.enumerated() {
            methods.append(value.key)
        }
        for (_,value) in config.asyncMethods.enumerated() {
            methods.append(value.key)
        }
//        [config.syncMethods enumerateKeysAndObjectsUsingBlock:mBlock];
//        [config.asyncMethods enumerateKeysAndObjectsUsingBlock:mBlock];
        
        sharedInstance.moduleLock.lock()
        
        return dict;
        
//        return Dictionary()
    }
    
    /**
     * @abstract Returns the export Selector in the specific module
     *
     * @param name The Selector name
     **/
    static func moduleSelectorMapsWithName(name:String)->Dictionary<String, Any>{
        
        var dict = Dictionary<String, Any>()
        var methods:Array<Any> = sharedInstance.defaultModuleMethod()
        
        sharedInstance.moduleLock.lock()
        dict[name] = methods
        let  config = (sharedInstance.moduleMap![name] as! HTModuleConfig)
        for (_, value) in config.syncMethods.enumerated() {
            methods.append(value.key)
        }
        for (_,value) in config.asyncMethods.enumerated() {
            methods.append(value.key)
        }
        sharedInstance.moduleLock.lock()
        
        
        return dict;
    }
    /**
     * @abstract Returns the registered modules.
     */
    static func  moduleConfigs()->Dictionary<String, Any>{
        var moduleDic = Dictionary<String, Any>()
        
//        void (^moduleBlock)(id, id, BOOL *) = ^(id mKey, id mObj, BOOL * mStop) {
//            HTModuleConfig *moduleConfig = (HTModuleConfig *)mObj;
//            if (moduleConfig.clazz && moduleConfig.name) {
//                [moduleDic setObject:moduleConfig.clazz forKey:moduleConfig.name];
//            }
//        };
        
        for (_,value) in sharedInstance.moduleMap!.enumerated() {
            let moduleConfig = HTModuleConfig()
            moduleConfig.name = value.key
            moduleConfig.clazz = value.value as! String
            moduleDic[moduleConfig.name] = moduleConfig.clazz
//            var moduleConfig = value as HTModuleConfig()
//            if moduleConfig.clazz != nil && moduleConfig.name != nil {
//
//            }
          
        }
        
//        [_moduleMap enumerateKeysAndObjectsUsingBlock:moduleBlock];
        return moduleDic;
    }
    
    func defaultModuleMethod()->Array<Any>
    {
        let arr:Array<Any> = ["addEventListener","removeAllEventListeners"]
        return arr
    }
}
