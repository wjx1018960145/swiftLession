//
//  UIBarButtonItemExtensionViewController.swift
//  SwiftLession01
//
//  Created by wjx on 2022/5/12.
//

import UIKit

class UIBarButtonItemExtensionViewController: TestBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        headDataArray = ["一、基本的扩展"]
        dataArray = [["快捷创建 UIBarButtonItem"]]
        // Do any additional setup after loading the view.
    }
    @objc func click(sender: UIButton) {
        print("点击事件")
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
// MARK: - 一、基本的扩展
extension UIBarButtonItemExtensionViewController {
    
    // MARK: 1.1、快捷创建 UIBarButtonItem
    @objc func test11() {
       let barButtonItem = UIBarButtonItem.jx.createBarbuttonItem(name: "mark", target: self, action: #selector(click))
       self.navigationItem.rightBarButtonItem = barButtonItem
    }
}

