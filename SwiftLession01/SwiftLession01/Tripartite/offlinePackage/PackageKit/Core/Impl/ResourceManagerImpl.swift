//
//  ResourceManagerImpl.swift
//  SwiftLession01
//
//  Created by wjx on 2022/8/16.
//

import UIKit

class ResourceManagerImpl: NSObject,ResourceManager {
    
    func updateResource(packageId: String, version: String) -> Bool {
        
        return true
    }
    
    func setResourceValidator(validator: ResoureceValidator) {
        
    }
    
    func getPackageId(url: String) -> String {
        return ""
    }
    

}
