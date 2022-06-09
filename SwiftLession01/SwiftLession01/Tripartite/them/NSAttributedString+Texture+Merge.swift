//
//  NSAttributedString+Texture+Merge.swift
//  SwiftLession01
//
//  Created by wjx on 2022/6/8.
//

import Foundation

extension NSAttributedString {
    // Initialize a new attributed string from an existing attributed string,
    // merging the specified attributes.
    // The specified attributes overwrite existing attributes with the
    /// same keys. All other attributes are preserved.
    convenience init(attributedString attrStr: NSAttributedString,
                     merged newAttributes: [NSAttributedString.Key: Any]) {
        let newString = NSMutableAttributedString(attributedString: attrStr)
        let range = NSMakeRange(0, attrStr.length)
        newString.enumerateAttributes(in: range, options: []) {
            (currentAttributes, range, _) in
            let mergedAttributes = currentAttributes.mergedAttributes(with: newAttributes)
            newString.setAttributes(mergedAttributes, range: range)
        }
        self.init(attributedString: newString)
    }
}

// Merge a dictionary into another dictionary, returning a new dictionary.
// The values of the other dictionary overwrite the values of the current
// dictionary.
private extension Dictionary {
    func mergedAttributes(with dict: Dictionary) -> Dictionary {
        return dict.reduce(into: self) { (result, pair) in
            let (key, value) = pair
            result[key] = value
        }
    }
}
