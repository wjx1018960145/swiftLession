//
//  UIRefreshControl+TitleAttributes.swift
//  SwiftLession01
//
//  Created by wjx on 2022/5/21.
//

import Foundation
import UIKit

#if os(iOS)
extension UIRefreshControl {
    @objc func updateTitleAttributes(_ newAttributes: [NSAttributedString.Key: Any]) {
        guard let title = self.attributedTitle else { return }
        let newString = NSAttributedString(attributedString: title,
                                           merging: newAttributes)
        self.attributedTitle = newString
    }
}
#endif
