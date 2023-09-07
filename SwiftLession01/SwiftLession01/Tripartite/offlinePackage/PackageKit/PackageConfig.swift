//
//  PackageConfig.swift
//  SwiftLession01
//
//  Created by wjx on 2022/8/16.
//

import UIKit

class PackageConfig: NSObject {
    
     var enableAssets:Bool = true;
     var enableBsDiff:Bool = false;
    var assetPath:String = "package.zip"
    
    
    
    public func  isEnableAssets()->Bool {
        return enableAssets;
    }
    
    public func  isEnableBsDiff()->Bool {
        return enableBsDiff;
    }
    
    public func getAssetPath()->String {
        return assetPath;
    }
    
    
}
