//
//  WJXVCRouter.swift
//  SwiftLession01
//
//  Created by wjx on 2022/6/21.
//

import Foundation
import JLRoutes
import RxSwift
import UIKit
import Alamofire
import SwiftUI
private let nameSpace = Bundle.main.infoDictionary?["CFBundleExecutable"] as! String
class WJXVCRouter: NSObject{
    
    
    
    static let  kWJXVCRouteClassName:String = "class"
    static let  kWJXVCRouteClassTitle:String = "title"
    static let  kWJXVCRouteClassFlags:String = "flags"
    static let  kWJXVCRouteClassNeedLogin:String = "needLogin"
    
    static let kWJXVCRouteSegue = "WJXVCRouteSegue"
    static let kWJXVCRouteAnimated = "WJXVCRouteAnimated"
    static let kWJXVCRouteBackIndex = "WJXVCRouteBackIndex"
    static let kWJXVCRouteBackPage = "WJXVCRouteBackPage"
    
    static let kWJXVCRouteIndexRoot = "root"
    static let kWJXVCRouteSeguePush = "push"
    static let kWJXVCRouteSegueModal = "modal"
    static let kWJXVCRouteSegueBack = "/back"
    static let kWJXVCRouteSegueNeedNavigation = "WJXVCRouteNeedNavigation"
    static let  utils=Utils()
    static  var tmpVc:UIViewController?
    static func openURL(url:NSString)->Bool{
        return self.routeURL(url: url as String, parameters: nil)
    }//调用 Router;
    static func openURL(url:NSString,parameters:NSDictionary)->Bool{
        return self.routeURL(url: url as String, parameters: parameters as? [String : Any])
    }
    
    static func addRoute(route:NSString,handler:@escaping (_ res:[String : Any])->Bool){
        JLRoutes.addRoute(route as String, handler: handler)
    }//注册 Router,调用 Router 时会触发回调       ;
    private static func routeURL(url:String,parameters:[String:Any]?) -> Bool{
        
        
        return JLRoutes.routeURL(URL(string: url), withParameters: parameters)
    }

}

extension WJXVCRouter {
    

    static func registerRouter(routerMapInfo:NSDictionary){
        
       
        
        for router in routerMapInfo.allKeys {
            let routerMap:NSDictionary = routerMapInfo[router] as! NSDictionary;
            let className:String = routerMap[kWJXVCRouteClassName] as! String;
            /*注册所有控制器 Router, 使用 [WJXVCRouter openURL:WJXVCRouteAppear]; push 到 AppearVC;
             [WJXVCRouter openURL:WJXVCRouteAppear parameters:@{kWJXVCRouteSegue: kWJXVCRouteSegueModal, @"name": @"jersey"}];  Modal 到 Appear VC 并携带参数 name;
             */
            if !(className.isEmpty || className.isKind(of: NSNull.self) || className.isKind(of: NSString.self) && (className.count == 0)){
                self.addRoute(route: router as! NSString) { res in
                    return self.executeRouterClassName(className: className, routerMap: routerMap, parameters: res as [String:AnyObject])
                }
        }
    }
  }
    static func executeRouterClassName(className:String,routerMap:NSDictionary,parameters:[String:AnyObject]) ->Bool{
        // 拦截 Router 映射参数,是否需要登录才可跳转;
        let needLogin = routerMap[kWJXVCRouteClassNeedLogin] as! String
        
        if needLogin == "1" {
           _ = WJXVCRouter.openURL(url: "Pages/Login$Regs/login");
            return false
        }
        //统一初始化控制器,传参和跳转;
        let vc = self.viewControllerWithClassName(className: className, routerMap: routerMap, parameters: parameters)
        if  !vc.isEqual(nil) {
            //跳转页面
            self.gotoViewController(vc: vc, parameters: parameters)
//            self gotoViewController:vc parameters:parameters];
            return true
        } else {
            return false
        }
        
    }
    
    private static func viewControllerWithClassName(className: String,routerMap:NSDictionary,parameters:[String:AnyObject]) ->UIViewController{
        
        var vc = self.createInstance(by: className) as? UIViewController //className.jx.toViewController()
        if vc == nil {
            vc = nil
        }
        
#if DEBUG
        //vc不是UIViewController
        
        //assert(vc != UIViewController.Type,"触发断言%s: "+className+" is not kind of UIViewController class");
#endif
//        let pros = self.createObjWithClassName(className)
       
        let propertyList = getAllPropertys(clsName: vc)
        
        self.setupParameters(params: parameters, vc: vc! )
       
        return vc!
    }
    /// 通过字符串生成对应的控制器类,将泛型约束变窄,万一有一个非控制器类可以生成有正好遵守了RouteViewControllerProtocol,会出问题,改会原来的样子
    /// - Parameter className: 类名字符串
    /// - Returns: 类
    private static func createInstance<T: NSObject>(by className: String) -> T? {
        guard let `class` = NSClassFromString(nameSpace + "." + className), let typeClass = `class` as? T.Type else {
            return nil
        }
        return typeClass.init()
    }
    override func responds(to aSelector: Selector!) -> Bool {
        
        return (WJXVCRouter.tmpVc?.responds(to: aSelector)) != nil
    }
//    override func perform(_ aSelector: Selector!) -> Unmanaged<AnyObject>! {
//
//    }
    private static func setupParameters(params:[String:AnyObject],vc:UIViewController){
        
        WJXVCRouter.tmpVc = vc
//        let hasKeys = vc.responds(to:NSSelectorFromString("test"))
        for key in params.allKeys() {
            let selector = Selector.init(key)
            let hasKey = vc.responds(to: selector)
            let hasMethodWithParamsKey = vc.responds(to:NSSelectorFromString(key+":"))

            //respondsToSelector .responds(to: NSSelectorFromString(key as! String))
            let notNil = params[key] != nil
            if (hasKey && notNil)   {
                let value = params[key]
                
                vc.setValue(value, forKey: key )

            }
            
            if hasMethodWithParamsKey && notNil{
                vc.perform(Selector.init(key+":"),with: params[key])
//                vc.setValue(value, forKey: key+":" )
            }
           
#if DEBUG
            //vc没有相应属性，但却传了值
            if ((key ).jx.isHasPrefix(prefix: "JLRoute") == false &&
                (key ).jx.isHasPrefix(prefix: "WJXVCRoute") == false) {
//                assert(hasKey == true,  file: "is not property for the key");
            }
#endif
            
        }
    }
    
    private static func gotoViewController(vc:UIViewController,parameters:[String:AnyObject]){
        let currentVC = self.topViewController()
        let segue = (parameters[kWJXVCRouteSegue] != nil) ? parameters[kWJXVCRouteSegue] as! String : kWJXVCRouteSeguePush;//  决定 present 或者 Push; 默认值 Push
        let animated = (parameters[kWJXVCRouteAnimated] != nil) ? parameters[kWJXVCRouteAnimated] as! Bool : true  // 转场动画;
        if segue == kWJXVCRouteSeguePush {
           
            let nav = currentVC!.navigationController
            if (nav != nil) {
                
                let backIndexString = parameters[kWJXVCRouteBackIndex]as? String
                
                let nav = currentVC!.navigationController
                
                if (backIndexString  ==  kWJXVCRouteIndexRoot) {
                    let vcs = NSMutableArray.init(objects: (nav?.viewControllers.first)! as UIViewController) //[NSMutableArray arrayWithObject:nav.viewControllers.firstObject];
                    vcs.add(vc)
                    nav?.setViewControllers(vcs as! [UIViewController], animated: true)
                   // [vcs addObject:vc];
                   // [nav setViewControllers:vcs animated:animated];
                    
                }else if backIndexString != nil  && backIndexString!.jx.toInt()! < nav!.viewControllers.count {
                   
                    
               
                    //移除掉指定数量的 VC, 在Push;
                        var vcs = NSMutableArray(array: nav!.viewControllers) as! Array<UIViewController>
                        let end = backIndexString!.jx.toInt()
                        let start = vcs.count - (backIndexString?.jx.toInt())!
                        
                        let range:Range? = NSMakeRange(start,end!).toRange()
                        
                        
                        vcs.removeSubrange(range!)
                    //[vcs removeObjectsInRange:NSMakeRange(vcs.count - [backIndexString integerValue], [backIndexString integerValue])];
                        nav!.viewControllers = vcs
                    vc.hidesBottomBarWhenPushed = true;
                    vc.title = parameters["title"] as? String
                        nav?.pushViewController(vc, animated: true)
//                    [nav pushViewController:vc animated:YES];
                    }else{
                        vc.title = parameters["title"] as? String
                        vc.hidesBottomBarWhenPushed = true;
                        nav?.pushViewController(vc, animated: true)
//                        [nav pushViewController:vc animated:animated];
                }
            } else { //由于无导航栏, 直接执行 Modal
                let needNavigation:Bool = (parameters[kWJXVCRouteSegueNeedNavigation] != nil) ? false : true;
                
                if (needNavigation) {
                    let navigationVC = UINavigationController(rootViewController: vc)
                    
//                    UINavigationController* navigationVC = [[UINavigationController alloc] initWithRootViewController:vc];
                    //vc.modalPresentationStyle = UIModalPresentationFullScreen;
                    currentVC?.present(navigationVC, animated: true)
//                    [currentVC presentViewController:navigationVC animated:YES completion:nil];
                }
                else {
                    currentVC?.present(vc, animated: true, completion: nil)
//                    currentVC?.presentModalViewController(navigationVC, animated: true)
//                    currentVC?.presentview
                    //vc.modalPresentationStyle = UIModalPresentationFullScreen;
//                    [currentVC presentViewController:vc animated:animated completion:nil];
                }
            }
        }else { //Modal
            let needNavigation = (parameters[kWJXVCRouteSegueNeedNavigation] != nil) ? parameters[kWJXVCRouteSegueNeedNavigation] as! Bool : false
            if (needNavigation ) {
                let navigationVC = UINavigationController(rootViewController: vc)
                //vc.modalPresentationStyle = UIModalPresentationFullScreen;
                currentVC?.present(navigationVC, animated: true, completion: nil)

            }
            else {
                //vc.modalPresentationStyle = UIModalPresentationFullScreen;
                currentVC?.present(vc, animated: true, completion: nil)
            }
        }
        
    }

    /// 获取顶层控制器
    /// - Parameter rootVC: 根控制器
    /// - Returns: 顶层控制器
    static func topViewController(_ rootVC: UIViewController? = UIApplication.shared.windows.first?.rootViewController) -> UIViewController? {
        if let nav = rootVC as? UINavigationController {
            return topViewController(nav.visibleViewController)
        }
        
        if let tab = rootVC as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(selected)
            }
        }
        
        if let presented = rootVC?.presentedViewController {
            return topViewController(presented)
        }
        
        return rootVC
    }
    
    static func wjx_findVisibleViewController()->UIViewController {
        
        var currentViewController:UIViewController = self.topViewController()!
        
        let runLoopFind:Bool = true
        
        while (runLoopFind) {
            let ispres = currentViewController.presentedViewController
            if (ispres != nil) {
                currentViewController = currentViewController.presentedViewController!
            } else {
                if  currentViewController.isKind(of: UINavigationController.self) {
                    
                    let cur = currentViewController as! UINavigationController
                    currentViewController = cur.visibleViewController!
                }else if currentViewController.isKind(of: UITabBarController.self){
                    let tab = currentViewController as! UITabBarController
                    currentViewController = tab.selectedViewController!
                }else {
                    break
                }
            }
        }
        
        return currentViewController;
    }
    
    static func getAllPropertys(clsName: Any?) -> [String] {
        var result = [String]()
        let count = UnsafeMutablePointer<UInt32>.allocate(capacity: 0)
        let buff = class_copyPropertyList(clsName as? AnyClass, count)
        let countInt = Int(count[0])
        for i in 0..<countInt {
            if let temp = buff?[i] {
                let cname = property_getName(temp)
                let proper = String(cString: cname)
                result.append(proper)
            }
        }
        return result
    }
    static func getAllIvarList(clsName: Any?) -> [String] {
        var result = [String]()
        let count = UnsafeMutablePointer<UInt32>.allocate(capacity: 0)
        let buff = class_copyIvarList(object_getClass(clsName), count)
        let countInt = Int(count[0])
        for i in 0..<countInt {
            if let temp = buff?[i],let cname = ivar_getName(temp) {
                let proper = String(cString: cname)
                result.append(proper)
            }
        }
        return result
    }

}


//            print(hasKey)

//            let selectorName = key
//            let selectors = Selector.init(selectorName)
//            let text = vc.perform(selectors)
//            if vc.responds(to:selectors){
//                let block = Test {
//                    print("block")
//                }
//
//                self.perform(selector, with: block)
//            }



//            if vc.responds(to: selector) == true {
//                let ce = vc.perform(selector, with: nil)
//            }

