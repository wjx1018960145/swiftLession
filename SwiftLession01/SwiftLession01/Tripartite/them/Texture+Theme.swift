//
//  Texture+Theme.swift
//  SwiftLession01
//
//  Created by wjx on 2022/6/8.
//

import Foundation
import AsyncDisplayKit


extension ASTextNode {
    @objc func updateTextAttributes(_ newAttributes: [NSAttributedString.Key: Any]) {
        guard let text = self.attributedText else { return }
        
        self.attributedText = NSAttributedString(
            attributedString: text,
            merged: newAttributes
        )
    }
}

/// 如果Node.view中没有SwiftTheme中的属性,你可以自己实现类似下面的拓展, 或者你可以监听SwiftTheme的通知ThemeUpdateNotification
/// If Node.view does not have the Theme attribute in SwiftTheme, you can implementation extension like this,Or you can use SwiftTheme notification 'ThemeUpdateNotification'
@objc public extension ASTextNode
{
    var theme_textAttributes: ThemeStringAttributesPicker? {
        get { return ThemePicker.getThemePicker(self, "updateTextAttributes:") as? ThemeStringAttributesPicker }
        set { ThemePicker.setThemePicker(self, "updateTextAttributes:", newValue) }
    }
    
    var theme_attributedText: ThemeAttributedStringPicker? {
        get { return ThemePicker.getThemePicker(self, "setAttributedText:") as? ThemeAttributedStringPicker }
        set { ThemePicker.setThemePicker(self, "setAttributedText:", newValue) }
    }
}

@objc public extension ASImageNode
{
    var theme_image: ThemeImagePicker? {
        get { return ThemePicker.getThemePicker(self, "setImage:") as? ThemeImagePicker }
        set { ThemePicker.setThemePicker(self, "setImage:", newValue) }
    }
}

@objc public extension ASButtonNode
{
    func theme_setImage(_ picker: ThemeImagePicker?, forState state: UIControl.State) {
        let statePicker = ThemePicker.makeStatePicker(self, "setImage:forState:", picker, state)
        ThemePicker.setThemePicker(self, "setImage:forState:", statePicker)
    }
    func theme_setBackgroundImage(_ picker: ThemeImagePicker?, forState state: UIControl.State) {
        let statePicker = ThemePicker.makeStatePicker(self, "setBackgroundImage:forState:", picker, state)
        ThemePicker.setThemePicker(self, "setBackgroundImage:forState:", statePicker)
    }
    
    func theme_setAttributedTitle(_ picker: ThemeAttributedStringPicker?, forState state: UIControl.State) {
        let statePicker = ThemePicker.makeStatePicker(self, "setAttributedTitle:forState:", picker, state)
        ThemePicker.setThemePicker(self, "setAttributedTitle:forState:", statePicker)
    }
}
