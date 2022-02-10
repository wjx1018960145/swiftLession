//
//  JXPOP.swift
//  SwiftLession01
//
//  Created by wjx on 2022/2/10.
//

import Foundation
import UIKit
import MapKit

public struct JXPOP<Base>{
    let base:Base
    init(_ base:Base){
        self.base = base
    }
}

public protocol JXPOPCompatible{}

public extension JXPOPCompatible {
    static var jx:JXPOP<Self>.Type {
        get{JXPOP<Self>.self}
        set{}
    }
    
    var jx:JXPOP<Self>{
        get{JXPOP(self)}
        set{}
    }
}

internal protocol JXSwiftPropertyCompatible{
    associatedtype T
    typealias SwiftCallBack = ((T?)->())
    var swiftCallBack:SwiftCallBack?{
        get set
    }
}


