//
//  HTSDKManager.swift
//  SwiftLession01
//
//  Created by wjx on 2022/6/30.
//

import UIKit
import Foundation

class HTSDKManager: NSObject {
    
    static var sharedInstance = HTSDKManager()
    
    var  bridgeMgr:HTBridgeManager?
    var  instanceDict = Dictionary<String, Any>()
    
    static func bridgeMgr()->HTBridgeManager{
        var result = self.sharedInstance.bridgeMgr
        if (result == nil) {
            // devtool may invoke "unload" and set bridgeMgr to nil
            result = HTBridgeManager.sharedManager
            self.sharedInstance.bridgeMgr = result;
        }
        return result!
    }
    
}
