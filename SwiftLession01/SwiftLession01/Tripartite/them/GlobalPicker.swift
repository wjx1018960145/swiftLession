//
//  GlobalPicker.swift
//  SwiftLession01
//
//  Created by wjx on 2022/6/7.
//

import Foundation

enum GlobalPicker {
    static let backgroundColor: ThemeColorPicker = ["#fff", "#fff", "#fff", "#292b38"]
    static let textColor: ThemeColorPicker = ["#000", "#000", "#000", "#ECF0F1"]
    
    static let barTextColors = ["#FFF", "#000", "#FFF", "#FFF"]
    static let barTextColor = ThemeColorPicker.pickerWithColors(barTextColors)
    static let barTintColor: ThemeColorPicker = ["#EB4F38", "#F4C600", "#56ABE4", "#01040D"]
}
