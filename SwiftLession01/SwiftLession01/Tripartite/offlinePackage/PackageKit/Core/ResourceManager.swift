//
//  ResourceManager.swift
//  SwiftLession01
//
//  Created by wjx on 2022/8/16.
//

import UIKit

 protocol ResourceManager: NSObject {
    
//    WebResourceResponse getResource(String url);
    
    func updateResource( packageId:String,  version:String)->Bool;
    
    func setResourceValidator(validator:ResoureceValidator)->Void;
    
    func getPackageId(url:String)->String;
}
