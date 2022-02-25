//
//  JXPOP.swift
//  SwiftLession01
//
//  Created by wjx on 2022/2/21.
//

import UIKit
import Foundation
public struct JXPOP<Base> {
    let base: Base
    init(_ base: Base) {
        self.base = base
    }
}

public protocol JXPOPCompatible {}

public extension JXPOPCompatible {
    
    static var jx: JXPOP<Self>.Type {
        get{ JXPOP<Self>.self }
        set {}
    }
    
    var jx: JXPOP<Self> {
        get { JXPOP(self) }
        set {}
    }
}

/// Define Property protocol
internal protocol JXSwiftPropertyCompatible {
  
    /// Extended type
    associatedtype T
    
    ///Alias for callback function
    typealias SwiftCallBack = ((T?) -> ())
    
    ///Define the calculated properties of the closure type
    var swiftCallBack: SwiftCallBack?  { get set }
}

