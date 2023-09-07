//
//  WKWebView+Protocol.swift
//  SwiftLession01
//
//  Created by wjx on 2022/7/5.
//

import Foundation
import WebKit

extension WKWebView{
    
    
    func supportURLProtocol(){
        
        let selector =  Selector(("registerSchemeForCustomProtocol:"))
        
        let vc = WKWebView().value(forKey: "browsingContextController") as AnyObject
        
        let cls  = type(of: vc) as AnyObject
        
        _ = cls.perform(selector, with: "http")
        _ = cls.perform(selector, with: "https")
        
        
    }
}


