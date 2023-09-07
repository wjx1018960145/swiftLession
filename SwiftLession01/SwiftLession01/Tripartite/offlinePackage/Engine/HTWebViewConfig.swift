//
//  HTWebViewConfig.swift
//  SwiftLession01
//
//  Created by wjx on 2022/6/27.
//

import UIKit

class HTWebViewConfig: NSObject {

    
    var enableWhiteList:Bool=false//是否存在白名单
    var whiteList:[String: Any]=[:]
    
    static let sharedInstance = HTWebViewConfig()
    
    
    
}
