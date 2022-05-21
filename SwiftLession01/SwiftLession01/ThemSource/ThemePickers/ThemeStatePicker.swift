//
//  ThemeStatePicker.swift
//  SwiftLession01
//
//  Created by wjx on 2022/5/21.
//

import Foundation
import UIKit

final class ThemeStatePicker: ThemePicker {
    
    typealias ValuesType = [UInt: ThemePicker]
    
    var values = ValuesType()
    
    convenience init?(picker: ThemePicker?, withState state: UIControl.State) {
        guard let picker = picker else { return nil }
        
        self.init(v: { 0 })
        values[state.rawValue] = picker
    }
    
    func setPicker(_ picker: ThemePicker?, forState state: UIControl.State) -> Self {
        values[state.rawValue] = picker
        return self
    }
    
}
