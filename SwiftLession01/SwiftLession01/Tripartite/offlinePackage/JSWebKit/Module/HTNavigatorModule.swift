//
//  HTNavigatorModule.swift
//  SwiftLession01
//
//  Created by wjx on 2022/6/30.
//

import UIKit
import WKWebViewJavascriptBridge

class HTNavigatorModule: NSObject,HTWebBridgeProtocol {
    
    
    func registerBridge(bridge: WKWebViewJavascriptBridge) -> Bool {
        
        bridge.register(handlerName: "push", handler: {(paramters, callback) in
            let  navigator = self.navigator() as! HTNavigationProtocol
            let container = self.htInstance
            navigator.pushViewControllerWithParam(param: paramters!, block: { code, responseData in
                if ((callback != nil)) {
                    callback!(code);
                }
            }, container: container)
        })
        return true
    }
    
    required override init() {
        
    }
    
    
    func navigator()->Any
    {
        let navigator = HTHandlerFactory.handlerForProtocol(pro:HTNavigationProtocol.self)
//
        return navigator;
    }

    var htInstance: UIViewController?
    

}
