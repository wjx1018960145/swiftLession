//
//  NSObjectExtensionViewController.swift
//  SwiftLession01
//
//  Created by wjx on 2022/4/18.
//

import UIKit

class NSObjectExtensionViewController: TestBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        headDataArray = ["一、 NSObject 属性的扩展", "二、一些常用的方法"]
        dataArray = [["类名（对象方法）", "类名（类方法）"], ["利用运行时获取类里面的成员变量"]]
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

// MARK: - 一、 NSObject 属性的扩展
extension NSObjectExtensionViewController {
    
    // MARK: 1.1、类名（对象方法）
    @objc func test11() {
        print("类名（对象方法）", "\(self.className)")
    }
    
    // MARK: 1.2、类名（类方法）
    @objc func test12() {
        print("类名（类方法）", "\(Self.className)")
    }
}

// MARK: - 二、一些常用的方法
extension NSObjectExtensionViewController {
    
    // MARK: 2.1、利用运行时获取类里面的成员变量
    @objc func test21() {
        print("利用运行时获取类里面的成员变量", "\(UIView.printIvars())")
    }
}
