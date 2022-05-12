//
//  CGFloatExtensionViewController.swift
//  SwiftLession01
//
//  Created by wjx on 2022/4/18.
//

import UIKit

class CGFloatExtensionViewController: TestBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        headDataArray = ["一、CGFloat 的基本转换", "二、角度和弧度相互转换"]
        dataArray = [["转 Int", "转 CGFloat", "转 Int64", "转 Float", "转 String", "转 NSNumber", "转 Double"], ["角度转弧度", "弧度转角度"]]
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
// MARK: - 二、角度和弧度相互转换
extension CGFloatExtensionViewController {
    
    // MARK: 2.1、角度转弧度
    @objc func test21() {
        let degrees: CGFloat = 90.0
        print("角度转弧度", "角度： \(degrees) 转为弧度后为：\(degrees.jx.degreesToRadians())")
    }
    
    // MARK: 2.2、弧度转角度
    @objc func test22() {
        let radians: CGFloat = .pi
        print("角度转弧度", "弧度： \(radians) 转为角度后为：\(radians.jx.radiansToDegrees())")
    }
}

// MARK: - 一、基本的扩展
extension CGFloatExtensionViewController {
    
    // MARK: 1.1、转 Int
    @objc func test11() {
        let value: CGFloat = 0.2
        print("转 Int", "\(value) 转 Int 后为 \(value.jx.int)")
    }
    
    // MARK: 1.2、转 CGFloat
    @objc func test12() {
        let value: CGFloat = 0.2
        print("转 CGFloat", "\(value) 转 CGFloat 后为 \(value.jx.cgFloat)")
    }
    
    // MARK: 1.3、转 Int64
    @objc func test13() {
        let value: CGFloat = 0.2
        print("转 Int64", "\(value) 转 Int64 后为 \(value.jx.int64)")
    }
    
    // MARK: 1.4、转 Float
    @objc func test14() {
        let value: CGFloat = 0.2
        print("转 Float", "\(value) 转 Float 后为 \(value.jx.float)")
    }
    
    // MARK: 1.5、转 String
    @objc func test15() {
        let value: CGFloat = 0.2
        print("转 String", "\(value) 转 String 后为 \(value.jx.string)")
    }
    
    // MARK: 1.6、转 NSNumber
    @objc func test16() {
        let value: CGFloat = 0.2
        print("转 NSNumber", "\(value) 转 NSNumber 后为 \(value.jx.number)")
    }
    
    // MARK: 1.7、转 Double
    @objc func test17() {
        let value: CGFloat = 0.2
        print("转 Double", "\(value) 转 Double 后为 \(value.jx.double)")
    }
}
