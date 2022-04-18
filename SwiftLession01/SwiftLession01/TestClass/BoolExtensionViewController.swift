//
//  BoolExtensionViewController.swift
//  SwiftLession01
//
//  Created by wjx on 2022/4/18.
//

import UIKit

class BoolExtensionViewController: TestBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        headDataArray = ["一、基本的扩展"]
        dataArray = [["Bool 值转 Int"]]
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
extension BoolExtensionViewController {
    
    // MARK: 1.1、Bool 值转 Int
    @objc func test11() {
        let value: Bool = true
        print("Bool 值转 Int", "\(value) 转 Int 后为 \(value.jx.boolToInt)")
    }
}
