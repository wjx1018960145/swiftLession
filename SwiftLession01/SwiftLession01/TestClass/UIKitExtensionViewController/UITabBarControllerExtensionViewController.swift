//
//  UITabBarControllerExtensionViewController.swift
//  SwiftLession01
//
//  Created by wjx on 2022/5/12.
//

import UIKit

class UITabBarControllerExtensionViewController: TestBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        headDataArray = ["一、基本扩展"]
        dataArray = [["当前选择索引"]]
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

// MARK: - 一、基本扩展
extension UITabBarControllerExtensionViewController {
    
    // MARK: 1.1、当前选择索引
    @objc func test11() {
        print("当前选择索引：\(UITabBarController.jx.selectedIdx)")
    }
}
