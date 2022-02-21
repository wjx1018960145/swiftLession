//
//  JXPOP.swift
//  SwiftLession01
//
//  Created by wjx on 2022/2/21.
//

import UIKit
import Foundation
public struct JSPOP<Base> {
    let base: Base
    init(_ base: Base) {
        self.base = base
    }
}

public protocol JSPOPCompatible {}

public extension JSPOPCompatible {
    
    static var jx: JSPOP<Self>.Type {
        get{ JSPOP<Self>.self }
        set {}
    }
    
    var jx: JSPOP<Self> {
        get { JSPOP(self) }
        set {}
    }
}

/// Define Property protocol
internal protocol JSSwiftPropertyCompatible {
  
    /// Extended type
    associatedtype T
    
    ///Alias for callback function
    typealias SwiftCallBack = ((T?) -> ())
    
    ///Define the calculated properties of the closure type
    var swiftCallBack: SwiftCallBack?  { get set }
}

