//
//  OneViewController.swift
//  SwiftLession01
//
//  Created by wjx on 2022/4/29.
//

import UIKit

class OneViewController: TestBaseViewController {
    var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "One"
        self.edgesForExtendedLayout = []
        self.view.backgroundColor = UIColor.randomColor
        
//        fd_prefersNavigationBarHidden = true
        
        let mainPath10 = UIBezierPath()
        mainPath10.move(to: CGPoint(x: 50, y: 50))
        mainPath10.addLine(to: CGPoint(x: 100, y: 100))
        let mainPath11 = UIBezierPath()
        mainPath11.move(to: CGPoint(x: 200, y: 300))
        mainPath11.addLine(to: CGPoint(x: 300, y: 400))
        // 多条路径合并
        mainPath11.append(mainPath11)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = mainPath11.cgPath //存入UIBezierPath的路径
        shapeLayer.fillColor = UIColor.brown.cgColor //设置填充色
        shapeLayer.lineWidth = 2  //设置路径线的宽度
        shapeLayer.strokeColor = UIColor.red.cgColor //路径颜色
        // 如果想变为虚线设置这个属性，[实线宽度，虚线宽度]，若两宽度相等可以简写为[宽度]
        shapeLayer.lineDashPattern = [2]
        // 一般可以填"path"  "strokeStart" "strokeEnd"  具体还需研究
        let baseAnimation = CABasicAnimation(keyPath: "strokeEnd")
        baseAnimation.duration = 2   //持续时间
        baseAnimation.fromValue = 0  //开始值
        baseAnimation.toValue = 2    //结束值
        baseAnimation.repeatDuration = 1  //重复次数
        shapeLayer.add(baseAnimation, forKey: nil) //给ShapeLayer添
        // 显示在界面上
        self.view.layer.addSublayer(shapeLayer)
        // Do any additional setup after loading the view.
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // self.present(UIViewControllerExtensionViewController(), animated: true, completion: nil)
        scrollView.contentOffset(CGPoint(x: 0, y: 20))
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
