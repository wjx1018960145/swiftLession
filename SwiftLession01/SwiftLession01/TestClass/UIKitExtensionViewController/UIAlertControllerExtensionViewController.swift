//
//  UIAlertControllerExtensionViewController.swift
//  SwiftLession01
//
//  Created by wjx on 2022/5/12.
//

import UIKit

class UIAlertControllerExtensionViewController: TestBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        headDataArray = ["一、基本的扩展"]
        dataArray = [["初始化创建 UIAlertController", "添加 UIAlertAction 事件", "添加 UIAlertAction 事件", "跳转 UIAlertController", "跳转 UIAlertController，不做操作自动返回"]]
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
// MARK: - 一、基本的链式编程
extension UIAlertControllerExtensionViewController {
    
    // MARK: 1.1、初始化创建 UIAlertController
    @objc func test11() {
        let alertController = UIAlertController(title: "主标题", message: "副标题")
        let alertAction = UIAlertAction(title: "确定", style: .default) { (alertAction) in
            print("确定")
        }
        alertController.addAction(alertAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    // MARK: 1.2、添加 UIAlertAction 事件
    @objc func test12() {
        let alertController = UIAlertController(title: "主标题", message: "副标题").addAction("确定", UIAlertAction.Style.default) {
            print("确定")
        }
        self.present(alertController, animated: true, completion: nil)
    }
    
    // MARK: 1.3、添加 UIAlertAction 事件
    @objc func test13() {
        let alertAction = UIAlertAction(title: "确定", style: .default) { (alertAction) in
            print("确定")
        }
        let alertController = UIAlertController(title: "主标题", message: "副标题").addAction(action: alertAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    // MARK: 1.4、跳转 UIAlertController
    @objc func test14() {
       let alertAction = UIAlertAction(title: "确定", style: .default) { (alertAction) in
           print("确定")
       }
       UIAlertController(title: "主标题", message: "副标题").addAction(action: alertAction).show()
    }
    
    // MARK: 1.5、跳转 UIAlertController，不做操作自动返回
    @objc func test15() {
        let alertAction = UIAlertAction(title: "确定", style: .default) { (alertAction) in
            print("确定")
        }
        UIAlertController(title: "主标题", message: "副标题").addAction(action: alertAction).show(self, dismiss: 3)
    }
}
