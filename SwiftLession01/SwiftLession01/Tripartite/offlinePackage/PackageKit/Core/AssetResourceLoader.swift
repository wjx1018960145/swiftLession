//
//  AssetResourceLoader.swift
//  SwiftLession01
//
//  Created by wjx on 2022/8/16.
//

import UIKit

 protocol AssetResourceLoader: NSObject {
    /**
     * asset资源路径信息
     * @param path
     */
    func load(path:String)->PackageInfo
    
}
