//
//  UIScreenExtensionViewController.swift
//  SwiftLession01
//
//  Created by wjx on 2022/5/12.
//

import UIKit

class UIScreenExtensionViewController: TestBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        headDataArray = ["一、基本的扩展"]
        dataArray = [["获取宽度", "获取高度", "截屏和录屏通知"]]
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
extension UIScreenExtensionViewController {
    
    // MARK: 1.1、获取宽度
    @objc func test11() {
        print("获取宽度：\(UIScreen.jx.width)")
    }
    
    // MARK: 1.2、获取高度
    @objc func test12() {
        print("获取高度：\(UIScreen.jx.height)")
    }
    
    // MARK: 1.3、截屏通知
    @objc func test13() {
        UIScreen.jx.detectScreenShot { (result) in
            print("\(result)")
        }
    }
}

