//
//  UILabel+TextAttributes.swift
//  SwiftLession01
//
//  Created by wjx on 2022/5/21.
//

import Foundation
import UIKit

extension UILabel {
    @objc func updateTextAttributes(_ newAttributes: [NSAttributedString.Key: Any]) {
        guard let text = self.attributedText else { return }
        
        self.attributedText = NSAttributedString(
            attributedString: text,
            merging: newAttributes
        )
    }
}
