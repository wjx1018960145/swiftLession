//
//  UIBezierPathExtensionViewController.swift
//  SwiftLession01
//
//  Created by wjx on 2022/5/12.
//

import UIKit

class UIBezierPathExtensionViewController: TestBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        headDataArray = ["一、基本的扩展"]
        dataArray = [["根据圆上任意三个点添加圆弧", "根据圆心和任意2个点添加圆弧"]]
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
extension UIBezierPathExtensionViewController {
    
    // MARK: 1.1、根据圆上任意三个点添加圆弧
    @objc func test11() {
        print("根据圆上任意三个点添加圆弧")
        
        let bezierPath = UIBezierPath()
        bezierPath.jx.addArc(startPoint: CGPoint(x: 200, y: 150), centerPoint: CGPoint(x: 300, y: 250), endPoint: CGPoint(x: 200, y: 350), clockwise: true)
        
        let shapeLayer = CAShapeLayer()
        // 存入UIBezierPath的路径
        shapeLayer.path = bezierPath.cgPath
        // 设置填充色
        shapeLayer.fillColor = UIColor.clear.cgColor
        // 设置路径线的宽度
        shapeLayer.lineWidth = 2
        shapeLayer.strokeColor = UIColor.green.cgColor //路径颜色
        
        let baseAnimation = CABasicAnimation(keyPath: "strokeEnd")
        // 持续时间
        baseAnimation.duration = 2
        // 开始值
        baseAnimation.fromValue = 0
        // 结束值
        baseAnimation.toValue = 2
        // 重复次数
        baseAnimation.repeatDuration = 1
        // 给ShapeLayer添
        shapeLayer.add(baseAnimation, forKey: nil)
        
        self.view.layer.addSublayer(shapeLayer)
        
        JXAsyncs.asyncDelay(3) {
        } _: {
            shapeLayer.removeFromSuperlayer()
        }
    }
    
    // MARK: 1.2、根据圆心和任意2个点添加圆弧
    @objc func test12() {
        print("CGPoint(x: 200, y: 350)")
        let bezierPath = UIBezierPath()
        bezierPath.jx.addArc(arcCenter: CGPoint(x: 200, y: 250), startPoint: CGPoint(x: 200, y: 150), endPoint: CGPoint(x: 200, y: 350), clockwise: false)
        
        let shapeLayer = CAShapeLayer()
        // 存入UIBezierPath的路径
        shapeLayer.path = bezierPath.cgPath
        // 设置填充色
        shapeLayer.fillColor = UIColor.clear.cgColor
        // 设置路径线的宽度
        shapeLayer.lineWidth = 2
        shapeLayer.strokeColor = UIColor.green.cgColor //路径颜色
        
        let baseAnimation = CABasicAnimation(keyPath: "strokeEnd")
        // 持续时间
        baseAnimation.duration = 2
        // 开始值
        baseAnimation.fromValue = 0
        // 结束值
        baseAnimation.toValue = 2
        // 重复次数
        baseAnimation.repeatDuration = 1
        // 给ShapeLayer添
        shapeLayer.add(baseAnimation, forKey: nil)
        
        self.view.layer.addSublayer(shapeLayer)
        
        JXAsyncs.asyncDelay(3) {
        } _: {
            shapeLayer.removeFromSuperlayer()
        }
    }
}
