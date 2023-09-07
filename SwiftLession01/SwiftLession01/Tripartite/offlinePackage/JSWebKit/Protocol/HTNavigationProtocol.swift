//
//  HTNavigationProtocol.swift
//  SwiftLession01
//
//  Created by wjx on 2022/6/30.
//

import Foundation
import UIKit

/**
 * This enum is used to define the position of navbar item.
 */
@objc enum HTNavigationItemPosition:Int {
        
    
   case HTNavigationItemPositionCenter = 0x00
    
   case HTNavigationItemPositionRight
    
   case HTNavigationItemPositionLeft
    
   case HTNavigationItemPositionMore
    
}

typealias   HTNavigationResultBlock = (_ code:String,_ responseData:Dictionary<String,Any>)->()
@objc protocol HTNavigationProtocol:HTWebBridgeProtocol {
    
    /**
     * @abstract Returns the navigation controller.
     *
     * @param container The target controller.
     */
    func navigationControllerOfContainer(container:UIViewController)->Any
    /**
     * @abstract Sets the navigation bar hidden.
     *
     * @param hidden If YES, the navigation bar is hidden.
     *
     * @param animated Specify YES to animate the transition or NO if you do not want the transition to be animated.
     *
     * @param container The navigation controller.
     *
     */
    func setNavigationBarHidden(hidden:Bool,animated:Bool,container:UIViewController)
    /**
     * @abstract Sets the background color of navigation bar.
     *
     * @param backgroundColor The background color of navigation bar.
     *
     * @param container The target controller.
     *
     */
    func setNavigationBackgroundColor(backgroundColor:UIColor,container:UIViewController)
    
    /**
     * @abstract Sets the item in navigation bar.
     *
     * @param param The data which is passed to the implementation of the protocol.
     *
     * @param position The value indicates the position of item.
     *
     * @param block A block called once the action is completed.
     *
     * @param container The target controller.
     *
     */
    func setNavigationItemWithParam(param:Dictionary<String,Any>,position:HTNavigationItemPosition,block:HTNavigationResultBlock,container:UIViewController)
    
    /**
     * @abstract Clears the item in navigation bar.
     *
     * @param param The data which is passed to the implementation of the protocol.
     *
     * @param position The value indicates the position of item.
     *
     * @param block A block called once the action is completed.
     *
     * @param container The target controller.
     *
     */
    func clearNavigationItemWithParam(param:Dictionary<String,Any>,position:HTNavigationItemPosition,block:HTNavigationResultBlock,container:UIViewController)
    /**
     * @abstract Pushes a view controller onto the receiver’s stack.
     *
     * @param param The data which is passed to the implementation of the protocol.
     *
     * @param block A block called once the action is completed.
     *
     * @param container The target controller.
     *
     */
    func pushViewControllerWithParam(param:Dictionary<String,Any>,block:HTNavigationResultBlock,container:UIViewController?)
    
    /**
     * @abstract Pops the top view controller from the navigation stack.
     *
     * @param param The data which is passed to the implementation of the protocol.
     *
     * @param block A block called once the action is completed.
     *
     * @param container The target controller.
     *
     */
    func popViewControllerWithParam(param:Dictionary<String,Any>,block:HTNavigationResultBlock,container:UIViewController)
}
