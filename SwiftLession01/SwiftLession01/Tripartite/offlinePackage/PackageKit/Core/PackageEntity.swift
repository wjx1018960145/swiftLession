//
//  PackageEntity.swift
//  SwiftLession01
//
//  Created by wjx on 2022/8/18.
//

import UIKit

class PackageEntity: NSObject {
    
    private var errorCode:Int = 0;
    private var  data:Array<Any> = [];
    
    public func setItems(data:Array<Any>)->Void {
        self.data = data;
    }
    
    public func getItems()->Array<Any> {
        return data;
    }
}
