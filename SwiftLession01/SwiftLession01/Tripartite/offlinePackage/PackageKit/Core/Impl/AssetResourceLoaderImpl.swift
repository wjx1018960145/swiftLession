//
//  AssetResourceLoaderImpl.swift
//  SwiftLession01
//
//  Created by wjx on 2022/8/16.
//

import UIKit

class AssetResourceLoaderImpl: NSObject,AssetResourceLoader {
    
    func load(path: String) -> PackageInfo {
        let mode = PackageInfo(coder: NSCoder.init())
        return mode!
    }
    

}
