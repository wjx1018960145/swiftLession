//
//  ResoureceValidator.swift
//  SwiftLession01
//
//  Created by wjx on 2022/8/16.
//

import UIKit

 protocol ResoureceValidator: NSObject {
    
    func validate(resourceInfo:ResourceInfo)->Void;
    
}
