//
//  UITextField+PlaceholderAttributes.swift
//  SwiftLession01
//
//  Created by wjx on 2022/5/21.
//

import Foundation
import UIKit

extension UITextField {
    @objc func updatePlaceholderAttributes(_ newAttributes: [NSAttributedString.Key: Any]) {
        guard let placeholder = self.attributedPlaceholder else { return }
        let newString = NSAttributedString(attributedString: placeholder,
                                           merging: newAttributes)
        self.attributedPlaceholder = newString
    }
}
