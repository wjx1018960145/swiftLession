//
//  FloatExtensionViewController.swift
//  SwiftLession01
//
//  Created by wjx on 2022/4/6.
//

import UIKit

class FloatExtensionViewController: TestBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        headDataArray = ["一、Float 与其他类型的转换", "二、其他常用的方法"]
        dataArray = [["转 Int", "Float四舍五入转Int", "转 CGFloat", "转 Int64", "转 Double", "转 String", "转 NSNumber", "转 Float"], ["浮点数四舍五入"]]
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
// MARK: - 二、其他常用的方法
extension FloatExtensionViewController {
    
    // MARK: 2.1、浮点数四舍五入
    @objc func test21() {
        let money: Float = 56789.654
        let price = money.jx.roundTo(places: 3)
        print("浮点数四舍五入", "\(money) 浮点数四舍五入 后为：\(price)")
    }
}

// MARK: - 一、基本的扩展
extension FloatExtensionViewController {
    
    // MARK: 1.8、转 Float
    @objc func test18() {
        let value: Float = 0.2
        print("转 Float", "\(value) 转 Float 后为 \(value.jx.float)")
    }
    
    // MARK: 1.7、转 NSNumber
    @objc func test17() {
        let value: Float = 0.2
        print("转 NSNumber", "\(value) 转 NSNumber 后为 \(value.jx.number)")
    }
    
    // MARK: 1.6、转 String
    @objc func test16() {
        let value: Float = 0.2
        print("转 String", "\(value) 转 String 后为 \(value.jx.string)")
    }
    
    // MARK: 1.5、转 Double
    @objc func test15() {
        let value: Float = 0.2
        print("转 Double", "\(value) 转 Double 后为 \(value.jx.double)")
    }
    
    // MARK: 1.4、转 Int64
    @objc func test14() {
        let value: Float = 0.2
        print("转 Int64", "\(value) 转 Int64 后为 \(value.jx.int64)")
    }
    
    // MARK: 1.3、转 CGFloat
    @objc func test13() {
        let value: Float = 0.2
        print("转 CGFloat", "\(value) 转 CGFloat 后为 \(value.jx.cgFloat)")
    }
    
    // MARK: 1.2、Float四舍五入转Int
    @objc func test12() {
        let value: Float = 23.46
        print("Float四舍五入转Int", "\(value) Float四舍五入转Int后为 \(value.jx.lroundfToInt)")
    }
    
    // MARK: 1.1、转 Int
    @objc func test11() {
        let value: Float = 0.2
        print("转 Int", "\(value) 转 Int 后为 \(value.jx.int)")
    }
}
