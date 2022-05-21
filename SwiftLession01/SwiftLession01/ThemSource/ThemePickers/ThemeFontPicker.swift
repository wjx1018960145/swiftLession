//
//  ThemeFontPicker.swift
//  SwiftLession01
//
//  Created by wjx on 2022/5/21.
//

import Foundation
import UIKit

@objc public final class ThemeFontPicker: ThemePicker {
    
    public convenience init(keyPath: String, map: @escaping (Any?) -> UIFont?) {
        self.init(v: { map(ThemeManager.value(for: keyPath)) })
    }
    
    public convenience init(fonts: UIFont...) {
        self.init(v: { ThemeManager.element(for: fonts) })
    }
    
    public required convenience init(stringLiteral value: String) {
        self.init(v: { ThemeManager.font(for: value) })
    }
    
    public required convenience init(arrayLiteral elements: UIFont...) {
        self.init(v: { ThemeManager.element(for: elements) })
    }
    
}

@objc public extension ThemeFontPicker {
    
    class func pickerWithKeyPath(_ keyPath: String, map: @escaping (Any?) -> UIFont?) -> ThemeFontPicker {
        return ThemeFontPicker(keyPath: keyPath, map: map)
    }
    
    class func pickerWithFonts(_ fonts: [UIFont]) -> ThemeFontPicker {
        return ThemeFontPicker(v: { ThemeManager.element(for: fonts) })
    }
    
}

extension ThemeFontPicker: ExpressibleByArrayLiteral {}
extension ThemeFontPicker: ExpressibleByStringLiteral {}

