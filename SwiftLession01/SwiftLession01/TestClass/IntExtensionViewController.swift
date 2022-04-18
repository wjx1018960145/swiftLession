//
//  IntExtensionViewController.swift
//  SwiftLession01
//
//  Created by wjx on 2022/4/18.
//

import UIKit

class IntExtensionViewController: TestBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        headDataArray = ["一、CGFloat 的基本转换", "二、其他常用方法"]
        dataArray = [["转 Double", "转 Float", "转 Int64", "转 CGFloat", "转 String", "转 UInt", "转 range"], ["取区间内的随机数，如取  0..<10 之间的随机数", "转换万单位", "计算大小"]]
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

// MARK: - 二、其他常用方法
extension IntExtensionViewController {
    
    // MARK: 2.3、计算大小
    @objc func test23() {

        guard let path = Bundle.main.path(forResource: "girl", ofType: "jpg") else {
            return
        }
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
            return
        }
        let image = UIImage(data: data)
        var imageView = UIImageView(frame: CGRect(x: 0, y: 150, width: 200, height: 300))
        imageView.image = image
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.jx.centerX = self.view.jx.centerX
        self.view.addSubview(imageView)
        JXAsyncs.asyncDelay(3) {
        } _: {
            imageView.removeFromSuperview()
        }
        let imageDataSize = data.count.jx.covertUInt64ToString()
       print("计算大小", "图片的大小为：\(imageDataSize)")
    }
    
    // MARK: 2.2、转换万单位
    @objc func test22() {
        let value: Int = 1001100
        print("转换万单位", "\(value) 保留 1 为 转换后为：\(value.jx.toTenThousandString())")
    }
    
    // MARK: 2.1、取区间内的随机数，如取  0..<10 之间的随机数"
    @objc func test21() {
        print("\(Int.jx.random(within: 0..<10))")
    }
}

// MARK: - 一、基本的扩展
extension IntExtensionViewController {
    
    // MARK: 1.1、转 Double
    @objc func test11() {
        let value: Int = 2
        print("转 Double", "\(value) 转 Double 后为 \(value.jx.intToFloat)")
    }
    
    // MARK: 1.2、转 Float
    @objc func test12() {
        let value: Int = 2
        print("转 Float", "\(value) 转 Float 后为 \(value.jx.intToFloat)")
    }
    
    // MARK: 1.3、转 Int64
    @objc func test13() {
        let value: Int = 2
        print("转 Int64", "\(value) 转 Int64 后为 \(value.jx.intToInt64)")
    }
    
    // MARK: 1.4、转 CGFloat
    @objc func test14() {
        let value: Int = 2
        print("转 CGFloat", "\(value) 转 CGFloat 后为 \(value.jx.intToCGFloat)")
    }
    
    // MARK: 1.5、转 String
    @objc func test15() {
        let value: Int = 2
        print("转 String", "\(value) 转 String 后为 \(value.jx.intToString)")
    }
    
    // MARK: 1.6、转 UInt
    @objc func test16() {
        let value: Int = 2
        print("转 UInt", "\(value) 转 UInt 后为 \(value.jx.intToUInt)")
    }
    
    // MARK: 1.7、转 range
    @objc func test17() {
        let value: Int = 2
        print("转 range", "\(value) 转 range 后为 \(value.jx.intToRange)")
    }
}
