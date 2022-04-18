//
//  RangeExtensionViewController.swift
//  SwiftLession01
//
//  Created by wjx on 2022/4/6.
//

import UIKit

class RangeExtensionViewController: TestBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        headDataArray = ["一、基本的扩展"]
        dataArray = [["Range转换成NSRange的方法"]]
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
extension RangeExtensionViewController {
    
    // MARK: 1.1、Range转换成NSRange的方法
    @objc func test11() {
        let string = "123456Hello World !!!"
        let subString = "Hello World"
        
        if let range = string.range(of: subString) {
            let nsRange = range.jx.toNSRange(in: string)
        print("Range转换成NSRange的方法", "父字符串为：\(string) 子字符串为：\(subString)", "子字符串在父字符串里面的range为 \(range) 转NSRange后为：\(nsRange)")
        }
    }
}
    
