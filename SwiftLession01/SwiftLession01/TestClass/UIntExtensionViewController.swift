//
//  UIntExtensionViewController.swift
//  SwiftLession01
//
//  Created by wjx on 2022/4/18.
//

import UIKit

class UIntExtensionViewController: TestBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        headDataArray = ["一、UInt 的基本转换"]
        dataArray = [["转 Int", "转 CGFloat", "转 Float", "转 Double", "转 String", "转 NSNumber", "转 Int64"]]
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
extension UIntExtensionViewController {
    
    // MARK: 1.1、转 Int
    @objc func test11() {
        let value: UInt = 2345
        print("转 Int", "\(value) 转 Int 后为 \(value.jx.uintToInt)")
    }
}
