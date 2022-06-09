//
//  ThemeNavigationBarAppearancePicker.swift
//  SwiftLession01
//
//  Created by wjx on 2022/5/21.
//

import Foundation
import UIKit

@available(iOS 15.0, tvOS 15.0, *)
@objc public final class ThemeNavigationBarAppearancePicker: ThemePicker {

    public convenience init(keyPath: String, map: @escaping (Any?) -> UINavigationBarAppearance?) {
        self.init(v: { map(ThemeManager.value(for: keyPath)) })
    }

    public convenience init(appearances: UINavigationBarAppearance...) {
        self.init(v: { ThemeManager.element(for: appearances) })
    }

    public required convenience init(arrayLiteral elements: UINavigationBarAppearance...) {
        self.init(v: { ThemeManager.element(for: elements) })
    }

}

@available(iOS 15.0, tvOS 15.0, *)
@objc public extension ThemeNavigationBarAppearancePicker {

    class func pickerWithKeyPath(_ keyPath: String, map: @escaping (Any?) -> UINavigationBarAppearance?) -> ThemeNavigationBarAppearancePicker {
        return ThemeNavigationBarAppearancePicker(keyPath: keyPath, map: map)
    }

    class func pickerWithAppearances(_ appearances: [UINavigationBarAppearance]) -> ThemeNavigationBarAppearancePicker {
        return ThemeNavigationBarAppearancePicker(v: { ThemeManager.element(for: appearances) })
    }
}
@available(iOS 15.0, tvOS 15.0, *)
extension ThemeNavigationBarAppearancePicker: ExpressibleByArrayLiteral {}
