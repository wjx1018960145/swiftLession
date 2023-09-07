//
//  HTBridgeManager.swift
//  SwiftLession01
//
//  Created by wjx on 2022/6/30.
//

import UIKit
import WKWebViewJavascriptBridge
//#ifdef __cplusplus
//extern "C" {
//#endif
//    void HTPerformBlockOnBridgeThread(void (^block)(void));
//    void HTPerformBlockSyncOnBridgeThread(void (^block) (void));
//    void HTPerformBlockOnBackupBridgeThread(void (^block)(void));
//
//    void HTPerformBlockOnBridgeThreadForInstance(void (^block)(void), NSString* instance);
//    void HTPerformBlockSyncOnBridgeThreadForInstance(void (^block) (void), NSString* instance);
//#ifdef __cplusplus
//}
//#endif

class HTBridgeManager: NSObject {
    static var sharedManager = HTBridgeManager()
    
    var containerViewController:UIViewController?
    // 拓展的plugin（每次增加新交互不用频繁修改基础组件）
    var pluginDic:Dictionary<String,AnyObject>?
    
    override init() {
        self.pluginDic = Dictionary()
    }
    // 注册基础 JavaScript 的处理
    func registerJavaScriptHandler(bridge:WKWebViewJavascriptBridge,ids:Any){
        //扩展插件（每次增加新交互不用频繁修改基础组件）
        let defaultArr = self.pluginDic?["DefaultMoudle"] as? Array<Any>
        if defaultArr != nil && defaultArr!.count != 0{
            for (_, plugin)  in defaultArr!.enumerated() {
                //        [plugin setHtInstance:ids];
                //            (plugin as! HTWebBridgeProtocol).htInstance = ids as! UIViewController;
                let clas = plugin as AnyObject
                
                _ = clas.registerBridge(bridge:bridge)
                //            _ =  ((plugin) as AnyObject).perform(Selector.init(("registerBridge:")),with: bridge) //registerBridge(bridge: bridge)
                
                //            [plugin registerBridge: bridge];
            }
        }
        
        
        let baseArr = self.pluginDic?["HTBaseViewController"] as? Array<Any>
        if baseArr != nil && baseArr!.count != 0{
            for (_,plugin)  in baseArr!.enumerated() {
                //        [plugin setHtInstance:ids];
                //            (plugin as! HTWebBridgeProtocol).htInstance = ids as! UIViewController;
                _ = (plugin as AnyObject).registerBridge(bridge: bridge)
                //            [plugin registerBridge: bridge];
            }
        }
      
    }
    //- (void)registerJavaScriptHandlerName:(NSString*)handlerName handler:(NSDictionary*)dic;
    func registerJavaScriptHandlerName(handlerName:String?,viewController:Any?){
        let arr = self.pluginDic![handlerName!]! as! Array<Any>
        for (_,plugin)  in arr.enumerated() {
            let vc = viewController as! HTH5ViewController
           _ = (plugin as! HTWebBridgeProtocol).registerBridge(bridge: vc.jsBridge!) //registerBridge:[(HTH5ViewController*)viewController jsBridge]];
        }
    }
    func initModulesName(moduleName:String?,modules:Dictionary<String,Any>?) {
        let plugValue = self.pluginDic![moduleName!]

        if (plugValue != nil) {
            var arrs = self.pluginDic![moduleName!] as! Array<Any>
            let arr = modules![moduleName!] as! Array<String>
            for (_,className) in arr.enumerated(){
                let cls: AnyObject =  className.jx.toClass()!  as AnyObject
                
                guard let clsType = cls as? NSObject.Type else{
                    print("Can not append")
                    return;
                }
                let vc = clsType.init()
                //        Class class = [[cls alloc] init];
//                let obje = type(of: cls).init()
                arrs.append(vc)
//                [arrs addObject:[[cls alloc]init]];
            }
        }
        else{
            var newarr = Array<Any>()
            let arr = modules![moduleName!] as! Array<String>
            for (_,className) in arr.enumerated() {
                let cls:AnyObject = className.jx.toClass()! as AnyObject
               
//                let cls : AnyClass? = NSClassFromString((clsName as! String) + "." + className)
                guard let clsType = cls as? NSObject.Type else{
                    print("Can not append")
                    return;
                }
                let vc = clsType.init()
                //        Class class = [[cls alloc] init];
//                let obje = type(of: cls).init()
                newarr.append(vc)
//                [newarr addObject:[[cls alloc]init]];
            }
            self.pluginDic![moduleName!] = newarr as AnyObject
//            [self.pluginDic setValue:newarr forKey:moduleName];
        }
    }
    func registerModules(moduleName:String?,dict:Dictionary<String,AnyObject>?){
        
    }
    static func currentViewController()->UIViewController {
        
        return UIViewController()
    }
    
}
