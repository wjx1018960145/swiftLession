//
//  UIViewControllerExtensionViewController.swift
//  SwiftLession01
//
//  Created by wjx on 2022/5/12.
//

import UIKit

class UIViewControllerExtensionViewController: TestBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        headDataArray = ["一、基本的扩展", "二、Storyboard 的 VC 交互"]
        dataArray = [["pop回上一个界面", "获取push进来的 VC", "获取顶部控制器(类方法)", "获取顶部控制器(实例方法)", "是否正在展示", "关闭当前的控制器"], ["push跳转Storyboard(首个初始化的控制器)", "push跳转到Storyboard中指定UIViewController"]]
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: - 二、Storyboard 的 VC 交互
extension UIViewControllerExtensionViewController {
    
    // MARK: 2.2、push跳转到Storyboard中指定UIViewController
    @objc func test22() {
        self.jx.pushStoryboard("MyStoryboard", identifier: "456") { (vc) in
        }
    }
    
    // MARK: 2.1、push跳转Storyboard(首个初始化的控制器)
    @objc func test21() {
        self.jx.pushStoryboard("MyStoryboard2") { (vc) in
        }
    }
}

// MARK: - 一、基本的扩展
extension UIViewControllerExtensionViewController {
    
    // MARK: 1.6、关闭当前的控制器
    @objc func test16() {
        print("关闭当前的控制器")
        self.jx.closeCurrentVC()
    }
    
    // MARK: 1.5、是否正在展示
    @objc func test15() {
        print("是否正在展示：\(self.jx.isCurrentVC)")
    }
    
    // MARK: 1.4、获取顶部控制器(实例方法)
    @objc func test14() {
        guard let vc = self.jx.topViewController() else {
            return
        }
        print("获取顶部控制器", "\(vc.className)")
    }
    
    // MARK: 1.3、获取顶部控制器(类方法)
    @objc func test13() {
        guard let vc = UIViewController.jx.topViewController() else {
            return
        }
        print("获取顶部控制器", "\(vc.className)")
    }
    
    // MARK: 1.2、获取push进来的 VC
    @objc func test12() {
        guard let vc = jx.getPreviousNavVC() else {
            return
        }
        print("pop回上一个界面", "\(vc.className)")
    }
    
    // MARK: 1.1、pop回上一个界面
    @objc func test11() {
        print("pop回上一个界面", "\(jx.popToPreviousVC())")
    }
}

