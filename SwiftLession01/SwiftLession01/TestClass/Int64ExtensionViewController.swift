//
//  Int64ExtensionViewController.swift
//  SwiftLession01
//
//  Created by wjx on 2022/4/18.
//

import UIKit

class Int64ExtensionViewController: TestBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        headDataArray = ["一、Int64 的基本转换"]
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
extension Int64ExtensionViewController {
    
    // MARK: 1.1、转 Int
    @objc func test11() {
        let value: Int64 = 2345
        print("转 Int", "\(value) 转 Int 后为 \(value.jx.int64ToInt)")
    }
    
    // MARK: 1.2、转 CGFloat
    @objc func test12() {
        let value: Int64 = 2345
        print("转 CGFloat", "\(value) 转 CGFloat 后为 \(value.jx.int64ToCGFloat)")
    }
    
    // MARK: 1.3、转 Float
    @objc func test13() {
        let value: Int64 = 2345
        print("转 Float", "\(value) 转 Float 后为 \(value.jx.int64ToFloat)")
    }
    
    // MARK: 1.4、转 Double
    @objc func test14() {
        let value: Int64 = 2345
        print("转 Double", "\(value) 转 Double 后为 \(value.jx.int64ToDouble)")
    }
    
    // MARK: 1.5、转 String
    @objc func test15() {
        let value: Int64 = 2345
       print("转 String", "\(value) 转 String 后为 \(value.jx.int64ToString)")
    }
    
    // MARK: 1.6、转 NSNumber
    @objc func test16() {
        let value: Int64 = 2345
        print("转 NSNumber", "\(value) 转 NSNumber 后为 \(value.jx.int64ToNumber)")
    }
    
    // MARK: 1.7、转 Int64
    @objc func test17() {
        let value: Int64 = 2345
        print("转 Int64", "\(value) 转 Int64 后为 \(value.jx.int64ToInt64)")
    }
}
