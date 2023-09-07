//
//  PackageInstaller.swift
//  SwiftLession01
//
//  Created by wjx on 2022/8/16.
//

import UIKit

 protocol PackageInstaller: NSObject {
    
    func install( packageInfo:PackageInfo,isAssets:Bool)->Bool
    
}
