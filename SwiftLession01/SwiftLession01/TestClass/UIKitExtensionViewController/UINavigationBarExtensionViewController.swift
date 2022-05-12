//
//  UINavigationBarExtensionViewController.swift
//  SwiftLession01
//
//  Created by wjx on 2022/5/12.
//

import UIKit

class UINavigationBarExtensionViewController: TestBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        headDataArray = ["一、基本的扩展"]
        dataArray = [["改变StateBar的颜色", "去掉 StateBar 的颜色"]]
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
// MARK: - 一、基本的扩展
extension UINavigationBarExtensionViewController {
    
    // MARK: 1.1、改变StateBar的颜色
    @objc func test11() {
        self.navigationController?.navigationBar.changeStateBarBackgroundColor(.green)
    }
    
    // MARK: 1.2、去掉 StateBar 的颜色
    @objc func test12() {
        self.navigationController?.navigationBar.resetBackgroundColor()
    }
}
