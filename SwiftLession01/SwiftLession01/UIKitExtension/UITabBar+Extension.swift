//
//  UITabBar+Extension.swift
//  SwiftLession01
//
//  Created by wjx on 2022/3/1.
//

import Foundation
import UIKit

public extension UITabBar {
    
    // MARK: 让图片和文字在iOS11下仍然保持上下排列
    /// 让图片和文字在iOS11下仍然保持上下排列
    override var traitCollection: UITraitCollection {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return UITraitCollection(horizontalSizeClass: .compact)
        }
        return super.traitCollection
    }
}
