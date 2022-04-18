//
//  NSRangeExtensionViewController.swift
//  SwiftLession01
//
//  Created by wjx on 2022/4/6.
//

import UIKit

class NSRangeExtensionViewController: TestBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        headDataArray = ["一、基本的扩展"]
        dataArray = [["NSRange转换成Range的方法"]]
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
extension NSRangeExtensionViewController {
    
    // MARK: 1.1、NSRange转换成Range的方法
    @objc func test11() {
        let string = "123456Hello World !!!"
        let nsRange = NSRange(location: 2, length: 2)
        
        if let range = nsRange.jx.toRange(string: string) {
            print("NSRange转换成Range的方法", "父字符串：\(string)", "\(nsRange) 转Range后为：\(range)")
        } else {
            print("没有拿到了range")
        }
    }
}
    
