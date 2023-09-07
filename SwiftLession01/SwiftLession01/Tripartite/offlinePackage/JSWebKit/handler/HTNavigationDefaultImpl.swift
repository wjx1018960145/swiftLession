//
//  HTNavigationDefaultImpl.swift
//  SwiftLession01
//
//  Created by wjx on 2022/6/30.
//

import UIKit
import WKWebViewJavascriptBridge

class HTNavigationDefaultImpl: NSObject,HTNavigationProtocol {
    func navigationControllerOfContainer(container: UIViewController) -> Any {
        
        return (Any).self
    }
    
    func setNavigationBarHidden(hidden: Bool, animated: Bool, container: UIViewController) {
        
    }
    
    func setNavigationBackgroundColor(backgroundColor: UIColor, container: UIViewController) {
        
    }
    
    func setNavigationItemWithParam(param: Dictionary<String, Any>, position: HTNavigationItemPosition, block: (String, Dictionary<String, Any>) -> (), container: UIViewController) {
        
    }
    
    func clearNavigationItemWithParam(param: Dictionary<String, Any>, position: HTNavigationItemPosition, block: (String, Dictionary<String, Any>) -> (), container: UIViewController) {
        
    }
    
    func pushViewControllerWithParam(param: Dictionary<String, Any>, block: (String, Dictionary<String, Any>) -> (), container: UIViewController?) {
        
        if (0 == param.count) {
            self.callback(block: block, code: MSG_PARAM_ERR as NSString, reposonData: nil)// callback:block code:MSG_PARAM_ERR data:nil];
            return;
        }
        print(param)
        
        
    }
    
    func popViewControllerWithParam(param: Dictionary<String, Any>, block: (String, Dictionary<String, Any>) -> (), container: UIViewController) {
        
    }
    
    func registerBridge(bridge: WKWebViewJavascriptBridge) -> Bool {
        return true
    }
    
    var htInstance: UIViewController?
    
    func callback(block:HTNavigationResultBlock,code:NSString,reposonData:Dictionary<String,Any>?)
    {
//        if (block) {
//            block(code, reposonData);
//        }
        block(code as String,reposonData!)
    }

}
