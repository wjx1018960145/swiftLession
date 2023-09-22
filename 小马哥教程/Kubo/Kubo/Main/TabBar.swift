//
//  TabBar.swift
//  Kubo
//
//  Created by wjx on 2023/9/21.
//

import UIKit

class TabBar: UITabBar {

    override func layoutSubviews() {
        super.layoutSubviews()
        
        for button in subviews where button is UIControl {
            
            var frame = button.frame
            
            frame.origin.y = -2
            button.frame = frame
            
            
        }
        
        
        
        
        
    }
    
}
