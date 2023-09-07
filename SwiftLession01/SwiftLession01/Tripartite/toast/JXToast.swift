//
//  JXToast.swift
//  SwiftLession01
//
//  Created by wjx on 2022/6/15.
//

import Foundation
import UIKit

/**
 *  Toast默认停留时间
 */
private let ToastDispalyDuration:CGFloat  = 1.2
/**
 *  Toast到顶端/底端默认距离
 */
private let ToastSpace:CGFloat = 100.0
/**
 *  Toast背景颜色
 */
private let ToastBackgroundColor = UIColor(red:0.2,green:0.2,blue:0.2,alpha:0.75)

//在window上显示
extension JXToast
{
    //MARK:-中间显示
    
    /**
     中间显示
     
     - parameter text: 文字
     */
    public class func showCenterWithText(_ text: String) {
        
        JXToast.showCenterWithText(text, duration:ToastDispalyDuration)
    }
    
    /**
     中间显示+自定义时间
     
     - parameter text:     文字
     - parameter duration: 自定义停留时间
     */
    public class func showCenterWithText(_ text:String,duration:CGFloat) {
        let toast = JXToast(text: text)
        toast.duration = duration
        toast.showIn(UIWindow.window())
    }

    // MARK:-上方显示
    
    /**
     上方显示
     
     - parameter text: 文字
     */
    public class func showTopWithText(_ text:String) {
        JXToast.showTopWithText(text, topOffset:ToastSpace, duration:ToastDispalyDuration)
    }
    
    /**
     上方显示+自定义停留时间
     
     - parameter text:     文字
     - parameter duration: 自定义停留时间
     */
    public class func showTopWithText(_ text:String, duration:CGFloat) {
        JXToast.showTopWithText(text, topOffset:ToastSpace, duration:duration)
    }
    
    /**
     上方显示+自定义到顶部距离
     
     - parameter text:      文字
     - parameter topOffset: 自定义到顶部距离
     */
    public class func showTopWithText(_ text:String,topOffset:CGFloat) {
        JXToast.showTopWithText(text, topOffset:topOffset, duration:ToastDispalyDuration)
    }
    
    /**
     上方显示+自定义到顶部距离+自定义停留时间
     
     - parameter text:      文字
     - parameter topOffset: 自定义到顶部距离
     - parameter duration:  自定义停留时间
     */
    public class func showTopWithText(_ text:String, topOffset:CGFloat,duration:CGFloat) {
        let toast = JXToast(text: text)
        toast.duration = duration
        toast.showIn(UIWindow.window(), topOffset: topOffset)
    }
    
    // MARK:-下方显示
    
    /**
     下方显示
     
     - parameter text: 文字
     */
    public class func showBottomWithText(_ text:String) {
        JXToast.showBottomWithText(text, bottomOffset:ToastSpace, duration:ToastDispalyDuration)
    }
    
    /**
     下方显示+自定义停留时间
     
     - parameter text:     文字
     - parameter duration: 自定义停留时间
     */
    public class func showBottomWithText(_ text:String,duration:CGFloat) {
        JXToast.showBottomWithText(text, bottomOffset:ToastSpace, duration:duration)
    }
    
    /**
     下方显示+自定义到底部距离
     
     - parameter text:         文字
     - parameter bottomOffset: 自定义到底部距离
     */
    public class func showBottomWithText(_ text:String,bottomOffset:CGFloat) {
        JXToast.showBottomWithText(text, bottomOffset:bottomOffset, duration:ToastDispalyDuration)
    }
    
    /**
     下方显示+自定义到底部距离+自定义停留时间
     
     - parameter text:         文字
     - parameter bottomOffset: 自定义到底部距离
     - parameter duration:     自定义停留时间
     */
    public class func showBottomWithText(_ text:String,bottomOffset:CGFloat,duration:CGFloat) {
        let toast: JXToast = JXToast(text: text)
        toast.duration = duration
        toast.showIn(UIWindow.window(), bottomOffset: bottomOffset)
    }
    
}

//在view上显示
extension UIView
{
    // MARK:- 中间显示
    
    /// 中间显示
    ///
    /// - Parameter text: 文字
    public func showJXToastCenterWithText(_ text:String){
        
        self.showJXToastCenterWithText(text, duration: ToastDispalyDuration)
    
    }
    
    
    /// 中间显示+自定义停留时间
    ///
    /// - Parameters:
    ///   - text: 文字
    ///   - duration: 自定义停留时间
    public func showJXToastCenterWithText(_ text:String , duration:CGFloat){
    
        let toast: JXToast = JXToast(text: text)
        toast.duration = duration
        toast.showIn(self)
    
    }
    
    
    // MARK:-上方显示
    
    /// 上方显示
    ///
    /// - Parameter text: 文字
    public func showJXToastTopWithText(_ text:String){
    
       self.showJXToastTopWithText(text, topOffset: ToastSpace, duration: ToastDispalyDuration)
    }
    
    
    /// 上方显示+自定义停留时间
    ///
    /// - Parameters:
    ///   - text: 文字
    ///   - duration: 自定义停留时间
    public func showJXToastTopWithText(_ text:String,  duration:CGFloat){
    
      self.showJXToastTopWithText(text, topOffset: ToastSpace, duration: duration)
    
    }
    
    
    /// 上方显示+自定义到顶部距离
    ///
    /// - Parameters:
    ///   - text: 文字
    ///   - topOffset: 自定义到顶部距离
    public func showJXToastTopWithText(_ text:String,topOffset:CGFloat){
    
        self.showJXToastTopWithText(text, topOffset: topOffset, duration: ToastDispalyDuration)
    
    }
    
    
    /// 上方显示+自定义到顶部距离+自定义停留时间
    ///
    /// - Parameters:
    ///   - text: 文字
    ///   - topOffset: 自定义到顶部距离
    ///   - duration: 自定义停留时间
    public  func showJXToastTopWithText(_ text:String,topOffset:CGFloat,duration:CGFloat) {
        
        let toast: JXToast = JXToast(text: text)
        toast.duration = duration
        toast.showIn(self, topOffset: topOffset)
        
    }
    

    //MARK:-下方显示
    
    /// 下方显示
    ///
    /// - Parameter text: 文字
    public func showJXToastBottomWithText(_ text:String){
        self.showJXToastBottomWithText(text, bottomOffset: ToastSpace, duration: ToastDispalyDuration)
    }
    
    
    /// 下方显示+自定义停留时间
    ///
    /// - Parameters:
    ///   - text: 文字
    ///   - duration: 自定义停留时间
    public func showJXToastBottomWithText(_ text:String,  duration:CGFloat){
        
         self.showJXToastBottomWithText(text, bottomOffset: ToastSpace, duration: duration)
        
    }
    
    
    /// 下方显示+自定义到顶部距离
    ///
    /// - Parameters:
    ///   - text: 文字
    ///   - topOffset: 自定义到顶部距离
    public func showJXToastBottomWithText(_ text:String,bottomOffset:CGFloat){
        
        self.showJXToastBottomWithText(text, bottomOffset: bottomOffset, duration: ToastDispalyDuration)
        
    }
    
    /// 下方显示+自定义到顶部距离+自定义停留时间
    ///
    /// - Parameters:
    ///   - text: 文字
    ///   - topOffset: 自定义到顶部距离
    ///   - duration: 自定义停留时间
    public  func showJXToastBottomWithText(_ text:String,bottomOffset:CGFloat,duration:CGFloat) {
        
        let toast: JXToast = JXToast(text: text)
        toast.duration = duration
        toast.showIn(self, bottomOffset: bottomOffset)
    }

}

extension UIWindow
{
    fileprivate class func window() -> UIWindow{
        let window = UIApplication.shared.windows.last!
        if(!window.isHidden){
            return window;
        }
        return (UIApplication.shared.delegate?.window!)!;
    }
}

open class JXToast:NSObject {
    
    var contentView: UIButton
    var duration:CGFloat
    
    init(text: String) {
        
        duration = ToastDispalyDuration
        
        let font = UIFont.boldSystemFont(ofSize: 16)
        let attributes = [NSAttributedString.Key.font: font]
        let rect = text.boundingRect(with: CGSize(width: 250,height: CGFloat.greatestFiniteMagnitude), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes:attributes, context: nil)
        let textLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: rect.size.width+40, height: rect.size.height+20))
        textLabel.backgroundColor = UIColor.clear
        textLabel.textColor = UIColor.white
        textLabel.textAlignment = NSTextAlignment.center
        textLabel.font = font
        textLabel.text = text
        textLabel.numberOfLines = 0
        contentView = UIButton(frame: CGRect(x: 0, y: 0, width: textLabel.frame.size.width, height: textLabel.frame.size.height))
        contentView.layer.cornerRadius = 20.0
        contentView.backgroundColor = ToastBackgroundColor
        contentView.addSubview(textLabel)
        contentView.autoresizingMask = UIView.AutoresizingMask.flexibleWidth
        
        super.init()
        
        contentView.addTarget(self, action:#selector(toastTaped(_:)), for: UIControl.Event.touchDown)
        contentView.alpha = 0.0
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func dismissToast() {
        contentView.removeFromSuperview()
    }
    
    @objc fileprivate func toastTaped(_ sender: UIButton) {
        
        self.hideAnimation()
    }
    
    fileprivate func showAnimation() {
        
        UIView.animate(withDuration: 0.3, delay: 0, options: UIView.AnimationOptions.curveEaseIn, animations: {
            
            self.contentView.alpha = 1.0
            
        }) { (completion) in
            
            
        }
    }
    
    fileprivate  func hideAnimation() {
        
        UIView.animate(withDuration: 0.3, delay: 0, options: UIView.AnimationOptions.curveEaseOut, animations: {
            
            self.contentView.alpha = 0.0
            
        }) { (completion) in
            
            
        }
        
    }
    
    fileprivate func showIn(_ view:UIView) {

        contentView.center = view.center
        view.addSubview(contentView)
        self.showAnimation()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(UInt64(duration) * NSEC_PER_SEC)) / Double(NSEC_PER_SEC)) {
            
            self.hideAnimation()
            
        }
    }
    
    fileprivate func showIn(_ view:UIView,topOffset top: CGFloat) {
        
        contentView.center = CGPoint(x: view.center.x, y: top+contentView.frame.size.height/2)
        view.addSubview(contentView)
        self.showAnimation()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(UInt64(duration) * NSEC_PER_SEC)) / Double(NSEC_PER_SEC)) {
            
            self.hideAnimation()
        }
    }
    
    fileprivate func showIn(_ view:UIView,bottomOffset bottom: CGFloat) {
        
        contentView.center = CGPoint(x: view.center.x, y: view.frame.size.height-(bottom+contentView.frame.size.height/2))
        view.addSubview(contentView)
        self.showAnimation()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(UInt64(duration) * NSEC_PER_SEC)) / Double(NSEC_PER_SEC)) {
            
            self.hideAnimation()
        }
    }
    
}


