//
//  UINavigationControllerExtensionViewController.swift
//  SwiftLession01
//
//  Created by wjx on 2022/4/29.
//

import UIKit

class UINavigationControllerExtensionViewController: TestBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        headDataArray = ["一、基本的扩展"]
        dataArray = [["pop返回后再push进某个控制器", "往前返回(Pop)几个控制器", "往前返回(Pop)几个控制器 后 push进某个控制器", "pop 到某个vc，以传入的vc类型为准，从栈顶逐个便利，直到找到这个vc，如果遍历完成后没找到，则返回false"]]
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
extension UINavigationControllerExtensionViewController {
    
    // MARK: 1.1、pop返回后再push进某个控制器
    @objc func test11() {
        self.navigationController?.jx.popCurrentAndPush(vc: OneViewController(), animated: true)
    }
    
    // MARK: 1.2、往前返回(Pop)几个控制器
    @objc func test12() {
        self.navigationController?.jx.pop(count: 2, animated: true)
    }
    
    // MARK: 1.3、往前返回(Pop)几个控制器 后 push进某个控制器
    @objc func test13() {
        self.navigationController?.jx.pop(count: 2, andPush: UITableViewExtensionViewController(), animated: true)
    }
    
    // MARK: 1.4、pop 到某个vc，以传入的vc类型为准，从栈顶逐个便利，直到找到这个vc，如果遍历完成后没找到，则返回false
    @objc func test14() {
        self.navigationController?.jx.popToViewController(as: ViewController.self, animated: true)
    }
    
}

