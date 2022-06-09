//
//  BubbleTabBarController.swift
//  BubbleTabBar
//
//  Created by Anton Skopin on 28/11/2018.
//  Copyright © 2018 cuberto. All rights reserved.
//

import UIKit

open class BubbleTabBarController: UITabBarController {

    fileprivate var shouldSelectOnTabBar = true

    open override var selectedViewController: UIViewController? {
        willSet {
            guard shouldSelectOnTabBar,
                  let newValue = newValue else {
                shouldSelectOnTabBar = true
                return
            }
            guard let tabBar = tabBar as? BubbleTabBar, let index = viewControllers?.index(of: newValue) else {
                return
            }
            tabBar.select(itemAt: index, animated: false)
        }
    }

    open override var selectedIndex: Int {
        willSet {
            guard shouldSelectOnTabBar else {
                shouldSelectOnTabBar = true
                return
            }
            guard let tabBar = tabBar as? BubbleTabBar else {
                return
            }
            tabBar.select(itemAt: selectedIndex, animated: false)
        }
    }

    open override func viewDidLoad() {
        super.viewDidLoad()
        let tabBar = BubbleTabBar()
        self.setValue(tabBar, forKey: "tabBar")
    }

    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    private var _barHeight: CGFloat = 74
    open var barHeight: CGFloat {
        get {
            if #available(iOS 11.0, *) {
                return _barHeight + view.safeAreaInsets.bottom
            } else {
                return _barHeight
            }
        }
        set {
            _barHeight = newValue
            updateTabBarFrame()
        }
    }

    private func updateTabBarFrame() {
        var tabFrame = self.tabBar.frame
        tabFrame.size.height = barHeight
        tabFrame.origin.y = self.view.frame.size.height - barHeight
        self.tabBar.frame = tabFrame
        tabBar.setNeedsLayout()
    }

    open override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateTabBarFrame()
    }

    open override func viewSafeAreaInsetsDidChange() {
        if #available(iOS 11.0, *) {
            super.viewSafeAreaInsetsDidChange()
        }
        updateTabBarFrame()
    }

    open override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard let idx = tabBar.items?.index(of: item) else {
            return
        }
        if let controller = viewControllers?[idx] {
            shouldSelectOnTabBar = false
            selectedIndex = idx
            delegate?.tabBarController?(self, didSelect: controller)
        }
    }

}

private var isAnimating = false

extension UITabBar {
    // 显示｜隐藏 TabBar 方法
    func changeTabBar(hidden:Bool, animated: Bool){
        if isAnimating { return }   // 如果动画正在执行，则不执行！
        if self.isHidden == hidden { return }  // 如果已经是指定隐藏状态，则不执行！
        
        /*=========================================*/
        // 修复在TabBar隐藏的情况下，旋转屏幕动画错乱的Bug!
        if self.isHidden {
            self.frame = CGRect(
                x: frame.minX,
                y: UIScreen.main.bounds.height,
                width: frame.width,
                height: frame.height
            ) // 强行修改tabBar的Frame
        }
        /*=========================================*/
        
        let frame = self.frame  // 获取自身的frame
        let isOutScreen = Int(UIScreen.main.bounds.height - self.frame.minY) == 0   // 是否在屏幕外面，以此为判断动画方向的依据！
        let a: CGFloat = isOutScreen ? -1 : 1   // 定义动画方向 | 上下
        let offset = a * frame.size.height  // 设置动画偏移量
        let duration: TimeInterval = (animated ? 0.5 : 0.0) // 定义动画持续时间
        
        self.isHidden = false // 开始动画之前，先开启tabBar的显示！
        isAnimating = true // 标记动画【正在执行】状态
        
        UIView.animate(
            withDuration: duration,
            animations: {
                self.center.y += offset // 改变【中心点】偏移量！
            }) { _ in
            self.isHidden = !isOutScreen    // 设置tabBar的显示状态
            isAnimating = false // 取消动画【正在执行】状态
        }
    }
}
