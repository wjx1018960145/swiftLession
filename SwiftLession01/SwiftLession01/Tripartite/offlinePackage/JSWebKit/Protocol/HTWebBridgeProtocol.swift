//
//  HTWebBridgeProtocol.swift
//  SwiftLession01
//
//  Created by wjx on 2022/6/30.
//

import Foundation
import UIKit
import WKWebViewJavascriptBridge
import UIKit


let MSG_SUCCESS:String     = "HT_SUCCESS"
let MSG_NO_HANDLER:String  = "HT_NO_HANDLER"
let MSG_NO_PERMIT:String   = "HT_NO_PERMISSION"
let MSG_FAILED :String     = "HT_FAILED"
let MSG_PARAM_ERR:String   = "HT_PARAM_ERR"
let MSG_EXP   :String      = "HT_EXCEPTION"

@objc protocol HTWebBridgeProtocol {
    // Plugin在 WebViewJavascriptBridge 中 注册
    func registerBridge(bridge:WKWebViewJavascriptBridge)->Bool
    var htInstance:UIViewController? { get set }
    
    
}
