//
//  CALayerExtensionViewController.swift
//  SwiftLession01
//
//  Created by wjx on 2022/4/29.
//

import UIKit

class CALayerExtensionViewController: TestBaseViewController , CAAnimationDelegate{
    var translatonAnimation: CABasicAnimation!
    lazy var testButton: UIView = {
        let testView = UIView()
        testView.frame = CGRect(x: 50, y: 100, width: 100, height: 100)
        testView.backgroundColor = UIColor.randomColor
        return testView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "测试", style: .plain, target: self, action: #selector(test62))
        
        headDataArray = ["一、自定义链式编程", "二、有关 CABasicAnimation 动画的扩展", "三、有关 CAKeyframeAnimation 动画的扩展", "四、有关 CATransition 动画的扩展", "五、有关 CASpringAnimation 弹簧动画的扩展", "六、有关 CAAnimationGroup 动画组的扩展"]
        dataArray = [["设置圆角", "设置背景色", "设置背景色 (十六进制字符串)", "设置frame", "添加到父视图(UIView)", "添加到父视图(CALayer)", "是否隐藏", "设置边框宽度", "设置边框颜色", "是否开启光栅化", "设置光栅化比例", "设置阴影颜色", "设置阴影的透明度", "设置阴影的偏移量", "设置阴影圆角", "高性能添加阴影 Shadow Path"], ["移动到另外一个 点(point)", "移动X", "移动Y", "圆角动画", "缩放动画", "旋转动画"], ["position移动动画", "设置 角度值 抖动", "根据 CGPath 进行做 移动 动画"], ["转场动画的使用"], ["弹簧动画：Bounds 动画"], ["CAAnimationGroup 的基类动画"]]
        // Do any additional setup after loading the view.
    }
    func animationDidStart(_ anim: CAAnimation) {
        print("animationDidStart:")
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        print("animationDidStop")
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

// MARK: - 六、有关 CAAnimationGroup 动画组的扩展
extension CALayerExtensionViewController {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        testButton.jx.x = scrollView.contentOffset.x + testButton.jx.x
        testButton.jx.y = scrollView.contentOffset.y + testButton.jx.y
        testButton.jx.width = 80
        testButton.jx.height = 80
        testButton.layer.cornerRadius = 40
        testButton.clipsToBounds = true
    }
    
    // MARK: CAAnimationGroup 动画
    @objc func test62() {
        self.view.addSubview(testButton)
    }
    // MARK: CAAnimationGroup 动画
    @objc func test61() {
        
        let testView = UIView()
        testView.frame = CGRect(x: 50, y: 100, width: 100, height: 100)
        testView.backgroundColor = UIColor.randomColor
        self.view.addSubview(testView)
        
        var imageView = UIImageView(frame: CGRect(x: 0, y: 150, width: 200, height: 200))
        imageView.image = UIImage(named: "ironman")
        imageView.jx.centerX = self.view.jx.centerX
        self.view.addSubview(imageView)
        
        let posAni = CABasicAnimation(keyPath: "position")
        posAni.toValue = CGPoint(x: 100, y: 150)
        
        let opcAni = CABasicAnimation(keyPath: "opacity")
        opcAni.toValue = 1.0
        opcAni.toValue = 0.7
        
        let bodAni = CABasicAnimation(keyPath: "bounds")
        bodAni.toValue = CGRect(x: 100, y: 150, width: 100, height: 100)
        
        JXAsyncs.asyncDelay(1) {
        } _: {
            imageView.layer.jx.baseAnimationGroup(animations: [posAni, opcAni, bodAni], duration: 3, repeatNumber: 1, removedOnCompletion: false, option: .default)
            JXAsyncs.asyncDelay(4) {
            } _: {
                testView.removeFromSuperview()
                imageView.removeFromSuperview()
            }
        }
        
        
    }
}

// MARK: - 五、有关 CASpringAnimation 弹簧动画的扩展
extension CALayerExtensionViewController {
    
    // MARK: 5.1、 弹簧动画：Bounds 动画
    @objc func test51() {
        var imageView = UIImageView(frame: CGRect(x: 0, y: 150, width: 200, height: 200))
        imageView.image = UIImage(named: "ironman")
        imageView.jx.centerX = self.view.jx.centerX
        self.view.addSubview(imageView)
        JXAsyncs.asyncDelay(1) {
        } _: {
            imageView.layer.jx.addSpringAnimationBounds(toValue: CGRect(x: 0, y: 150, width: 100, height: 100))
            JXAsyncs.asyncDelay(6) {
            } _: {
                imageView.removeFromSuperview()
            }
        }
    }
    
}

// MARK: - 四、有关 CATransition 动画的扩展
extension CALayerExtensionViewController {
    
    // MARK: 4.1、转场动画的使用
    @objc func test41() {
        
        var imageView = UIImageView(frame: CGRect(x: 0, y: 150, width: 200, height: 200))
        imageView.image = UIImage(named: "ironman")
        imageView.jx.centerX = self.view.jx.centerX
        self.view.addSubview(imageView)
        JXAsyncs.asyncDelay(2) {
        } _: {
            imageView.image = UIImage(named: "testicon")
            imageView.layer.jx.addTransition(type: .moveIn, subtype: .fromLeft, duration: 1.5)
            JXAsyncs.asyncDelay(2) {
            } _: {
                imageView.removeFromSuperview()
            }
        }
    }
}

// MARK: - 三、有关 CAKeyframeAnimation 动画的扩展
extension CALayerExtensionViewController {
    
    // MARK: 3.3、根据 CGPath 进行做 移动 动画
    @objc func test33() {
        
        let testLayer1 = CALayer().corner(100).borderWidth(2).borderColor(.randomColor)
        testLayer1.frame = CGRect(x: 100, y: 200, width: 200, height: 200)
        testLayer1.backgroundColor = UIColor.randomColor.cgColor
        self.view.layer.addSublayer(testLayer1)
        
        let testLayer = CALayer().corner(10)
        testLayer.frame = CGRect(x: 80, y: 80, width: 20, height: 20)
        testLayer.backgroundColor = UIColor.randomColor.cgColor
        self.view.layer.addSublayer(testLayer)
        
        let path = UIBezierPath(ovalIn: CGRect(x: 100, y: 200, width: 200, height: 200)).cgPath
        
        testLayer.jx.addKeyframeAnimationPositionBezierPath(path: path, duration: 5, delay: 2, repeatNumber: 2, removedOnCompletion: false, option: .default)
        
        JXAsyncs.asyncDelay(15) {
            
        } _: {
            testLayer.removeFromSuperlayer()
            testLayer.removeAllAnimations()
            testLayer1.removeFromSuperlayer()
        }
    }
    
    // MARK: 3.2、设置 角度值 抖动
    @objc func test32() {
        let testLayer = CALayer()
        testLayer.frame = CGRect(x: 80, y: 80, width: 80, height: 80)
        testLayer.backgroundColor = UIColor.green.cgColor
        self.view.layer.addSublayer(testLayer)
        
        testLayer.jx.addKeyframeAnimationRotation(keyTimes: nil)
        
        JXAsyncs.asyncDelay(3) {
            
        } _: {
            testLayer.removeFromSuperlayer()
            testLayer.removeAllAnimations()
        }
    }
    
    // MARK: 3.1、position移动动画
    @objc func test31() {
        
        let testLayer = CALayer().corner(0)
        testLayer.frame = CGRect(x: 80, y: 80, width: 80, height: 80)
        testLayer.backgroundColor = UIColor.green.cgColor
        self.view.layer.addSublayer(testLayer)
        
        let testView1 = UIView().corner(20)
        testView1.frame = CGRect(x: 100, y: 100, width: 40, height: 40)
        testView1.backgroundColor = UIColor.randomColor
        self.view.addSubview(testView1)
        
        let testView2 = UIView().corner(20)
        testView2.frame = CGRect(x: 250, y: 100, width: 40, height: 40)
        testView2.backgroundColor = UIColor.randomColor
        self.view.addSubview(testView2)
        
        let testView3 = UIView().corner(20)
        testView3.frame = CGRect(x: 100, y: 300, width: 40, height: 40)
        testView3.backgroundColor = UIColor.randomColor
        self.view.addSubview(testView3)
        
        let testView4 = UIView().corner(20)
        testView4.frame = CGRect(x: 250, y: 300, width: 40, height: 40)
        testView4.backgroundColor = UIColor.randomColor
        self.view.addSubview(testView4)
        
        let duration = 8
        let repeatNumber: Float = 2
        
        testLayer.jx.addKeyframeAnimationPosition(values: [testView1.jx.center, testView2.jx.center,  testView4.jx.center, testView3.jx.center, testView1.jx.center], keyTimes: nil, duration: TimeInterval(duration), repeatNumber: repeatNumber, removedOnCompletion: false, option: .default)
        
        JXAsyncs.asyncDelay(Double(duration) * Double(repeatNumber) + 2) {
            
        } _: {
            testView1.removeFromSuperview()
            testView2.removeFromSuperview()
            testView3.removeFromSuperview()
            testView4.removeFromSuperview()
            testLayer.removeFromSuperlayer()
            testLayer.removeAllAnimations()
        }
    }
    
}

// MARK: - 二、有关 CABasicAnimation 动画的扩展
extension CALayerExtensionViewController {
    
    // MARK: 2.6、旋转动画
    @objc func test26() {
        let testLayer1 = CALayer().corner(0)
        testLayer1.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        testLayer1.backgroundColor = UIColor.red.cgColor
        self.view.layer.addSublayer(testLayer1)
        
        let testLayer = CALayer().corner(0)
        testLayer.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        testLayer.backgroundColor = UIColor.green.cgColor
        self.view.layer.addSublayer(testLayer)
        
        testLayer.jx.animationRotation(rotation: Double.pi)
        
        JXAsyncs.asyncDelay(3) {
            
        } _: {
            testLayer1.removeFromSuperlayer()
            testLayer.removeFromSuperlayer()
            testLayer.removeAllAnimations()
        }
    }
    
    // MARK: 2.5、缩放动画
    @objc func test25() {
        let testLayer1 = CALayer().corner(0)
        testLayer1.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        testLayer1.backgroundColor = UIColor.red.cgColor
        self.view.layer.addSublayer(testLayer1)
        
        let testLayer = CALayer().corner(0)
        testLayer.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        testLayer.backgroundColor = UIColor.green.cgColor
        self.view.layer.addSublayer(testLayer)
        
        
        testLayer.jx.animationScale(scaleValue: 2)
        
        JXAsyncs.asyncDelay(3) {
            
        } _: {
            testLayer1.removeFromSuperlayer()
            testLayer.removeFromSuperlayer()
            testLayer.removeAllAnimations()
        }
    }
    
    // MARK: 2.4、圆角动画
    @objc func test24() {
        let testLayer1 = CALayer().corner(0)
        testLayer1.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        testLayer1.backgroundColor = UIColor.red.cgColor
        self.view.layer.addSublayer(testLayer1)
        
        let testLayer = CALayer().corner(0)
        testLayer.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        testLayer.backgroundColor = UIColor.green.cgColor
        self.view.layer.addSublayer(testLayer)
        
        
        testLayer.jx.animationCornerRadius(cornerRadius: 50)
        
        JXAsyncs.asyncDelay(3) {
            
        } _: {
            testLayer1.removeFromSuperlayer()
            testLayer.removeFromSuperlayer()
            testLayer.removeAllAnimations()
        }
    }
    
    // MARK: 2.3、移动Y
    @objc func test23() {
        let testLayer1 = CALayer()
        testLayer1.frame = CGRect(x: 200, y: 100, width: 100, height: 100)
        testLayer1.backgroundColor = UIColor.red.cgColor
        testLayer1.corner(12)
        self.view.layer.addSublayer(testLayer1)
        
        let testLayer2 = CALayer()
        testLayer2.frame = CGRect(x: 200, y: 300, width: 100, height: 100)
        testLayer2.backgroundColor = UIColor.yellow.cgColor
        testLayer2.corner(12)
        self.view.layer.addSublayer(testLayer2)
        
        let testLayer = CALayer()
        testLayer.frame = CGRect(x: 0, y: 100, width: 100, height: 100)
        testLayer.backgroundColor = UIColor.green.cgColor
        testLayer.corner(12)
        self.view.layer.addSublayer(testLayer)
        
        testLayer.jx.animationMoveY(moveValue: 100)
        
        JXAsyncs.asyncDelay(3) {
            
        } _: {
            testLayer1.removeFromSuperlayer()
            testLayer2.removeFromSuperlayer()
            testLayer.removeFromSuperlayer()
            testLayer.removeAllAnimations()
        }
    }
    
    // MARK: 2.2、移动X
    @objc func test22() {
        let testLayer1 = CALayer()
        testLayer1.frame = CGRect(x: 200, y: 100, width: 100, height: 100)
        testLayer1.backgroundColor = UIColor.red.cgColor
        testLayer1.corner(12)
        self.view.layer.addSublayer(testLayer1)
        
        let testLayer2 = CALayer()
        testLayer2.frame = CGRect(x: 200, y: 300, width: 100, height: 100)
        testLayer2.backgroundColor = UIColor.yellow.cgColor
        testLayer2.corner(12)
        self.view.layer.addSublayer(testLayer2)
        
        let testLayer = CALayer()
        testLayer.frame = CGRect(x: 0, y: 100, width: 100, height: 100)
        testLayer.backgroundColor = UIColor.green.cgColor
        testLayer.corner(12)
        self.view.layer.addSublayer(testLayer)
        
        testLayer.jx.animationMoveX(moveValue: 100)
        
        JXAsyncs.asyncDelay(3) {
            
        } _: {
            testLayer1.removeFromSuperlayer()
            testLayer2.removeFromSuperlayer()
            testLayer.removeFromSuperlayer()
            testLayer.removeAllAnimations()
        }
    }
    
    // MARK: 2.1、移动到另外一个 点(point)
    @objc func test21() {
        let testLayer1 = CALayer()
        testLayer1.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        testLayer1.backgroundColor = UIColor.red.cgColor
        testLayer1.corner(12)
        self.view.layer.addSublayer(testLayer1)
        
        let testLayer2 = CALayer()
        testLayer2.frame = CGRect(x: 200, y: 300, width: 100, height: 100)
        testLayer2.backgroundColor = UIColor.yellow.cgColor
        testLayer2.corner(12)
        self.view.layer.addSublayer(testLayer2)
        
        let testLayer = CALayer()
        testLayer.frame = CGRect(x: 200, y: 300, width: 100, height: 100)
        testLayer.backgroundColor = UIColor.green.cgColor
        testLayer.corner(12)
        self.view.layer.addSublayer(testLayer)
        testLayer.jx.animationCornerRadius(cornerRadius: 50)
        testLayer.jx.animationMovePoint(to: CGPoint(x: 150, y: 150), duration: 5, delay: 1, repeatNumber: 1, removedOnCompletion: false, option: .default)
        JXAsyncs.asyncDelay(6) {
            
        } _: {
            testLayer1.removeFromSuperlayer()
            testLayer2.removeFromSuperlayer()
            testLayer.removeFromSuperlayer()
            testLayer.removeAllAnimations()
        }
    }
}

// MARK: - 一、基本的扩展
extension CALayerExtensionViewController {
    
    // MARK: 1.1、设置圆角
    @objc func test11() {
        let testLayer = CALayer()
        testLayer.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        testLayer.backgroundColor = UIColor.green.cgColor
        testLayer.corner(12)
        self.view.layer.addSublayer(testLayer)
        JXAsyncs.asyncDelay(2, {
        }) {
            testLayer.removeFromSuperlayer()
        }
    }
    
    // MARK: 1.2、设置背景色
    @objc func test12() {
        let testLayer = CALayer()
        testLayer.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        testLayer.backgroundColor(UIColor.randomColor)
        self.view.layer.addSublayer(testLayer)
        JXAsyncs.asyncDelay(2, {
        }) {
            testLayer.removeFromSuperlayer()
        }
    }
    
    // MARK: 1.3、设置背景色 (十六进制字符串)
    @objc func test13() {
        let testLayer = CALayer()
        testLayer.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        testLayer.backgroundColor("#7B68EE")
        self.view.layer.addSublayer(testLayer)
        JXAsyncs.asyncDelay(2, {
        }) {
            testLayer.removeFromSuperlayer()
        }
    }
    
    // MARK: 1.4、设置frame
    @objc func test14() {
        let testLayer = CALayer()
        testLayer.frame(CGRect(x: 100, y: 100, width: 100, height: 100))
        testLayer.backgroundColor = UIColor.randomColor.cgColor
        self.view.layer.addSublayer(testLayer)
        JXAsyncs.asyncDelay(2, {
        }) {
            testLayer.removeFromSuperlayer()
        }
    }
    
    // MARK: 1.5、添加到父视图
    @objc func test15() {
        let testLayer = CALayer()
        testLayer.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        testLayer.backgroundColor = UIColor.randomColor.cgColor
        testLayer.addTo(self.view)
        JXAsyncs.asyncDelay(2, {
        }) {
            testLayer.removeFromSuperlayer()
        }
    }
    
    // MARK: 1.6、添加到父视图(CALayer)
    @objc func test16() {
        let testLayer = CALayer()
        testLayer.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        testLayer.backgroundColor = UIColor.randomColor.cgColor
        testLayer.addTo(self.view.layer)
        JXAsyncs.asyncDelay(2, {
        }) {
            testLayer.removeFromSuperlayer()
        }
    }
    
    // MARK: 1.7、是否隐藏
    @objc func test17() {
        let testLayer = CALayer()
        testLayer.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        testLayer.backgroundColor = UIColor.randomColor.cgColor
        testLayer.isHidden(false)
        testLayer.addTo(self.view.layer)
        JXAsyncs.asyncDelay(2, {
        }) {
            testLayer.removeFromSuperlayer()
        }
    }
    
    // MARK: 1.8、设置边框宽度
    @objc func test18() {
        let testLayer = CALayer()
        testLayer.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        testLayer.backgroundColor = UIColor.randomColor.cgColor
        testLayer.borderWidth(16)
        testLayer.addTo(self.view.layer)
        JXAsyncs.asyncDelay(2, {
        }) {
            testLayer.removeFromSuperlayer()
        }
    }
    
    // MARK: 1.9、设置边框颜色
    @objc func test19() {
        let testLayer = CALayer()
        testLayer.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        testLayer.backgroundColor = UIColor.randomColor.cgColor
        testLayer.borderWidth(16)
        testLayer.borderColor(.yellow)
        testLayer.addTo(self.view.layer)
        JXAsyncs.asyncDelay(2, {
        }) {
            testLayer.removeFromSuperlayer()
        }
    }
    
    // MARK: 1.10、是否开启光栅化
    @objc func test110() {
        let testLayer = CALayer()
        testLayer.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        testLayer.backgroundColor = UIColor.randomColor.cgColor
        testLayer.shouldRasterize(true)
        testLayer.addTo(self.view.layer)
        JXAsyncs.asyncDelay(2, {
        }) {
            testLayer.removeFromSuperlayer()
        }
    }
    
    // MARK: 1.11、设置光栅化比例
    @objc func test111() {
        let testLayer = CALayer()
        testLayer.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        testLayer.backgroundColor = UIColor.randomColor.cgColor
        testLayer.shouldRasterize(true)
        testLayer.rasterizationScale(0.8)
        testLayer.addTo(self.view.layer)
        JXAsyncs.asyncDelay(2, {
        }) {
            testLayer.removeFromSuperlayer()
        }
    }
    
    // MARK: 1.12、设置阴影颜色
    @objc func test112() {
        let testLayer = CALayer()
        testLayer.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        testLayer.backgroundColor = UIColor.randomColor.cgColor
        testLayer.shadowColor(.red)
        testLayer.addTo(self.view.layer)
        JXAsyncs.asyncDelay(2, {
        }) {
            testLayer.removeFromSuperlayer()
        }
    }
    
    // MARK: 1.13、设置阴影的透明度
    @objc func test113() {
        let testLayer = CALayer()
        testLayer.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        testLayer.backgroundColor = UIColor.randomColor.cgColor
        testLayer.shadowColor(.red)
        testLayer.shadowOpacity(0.68)
        testLayer.addTo(self.view.layer)
        JXAsyncs.asyncDelay(2, {
        }) {
            testLayer.removeFromSuperlayer()
        }
    }
    
    // MARK: 1.14、设置阴影的偏移量
    @objc func test114() {
        let testLayer = CALayer()
        testLayer.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        testLayer.backgroundColor = UIColor.randomColor.cgColor
        testLayer.shadowColor(.red)
        testLayer.shadowOpacity(0.68)
        testLayer.shadowOffset(CGSize(width: 1, height: 1))
        testLayer.addTo(self.view.layer)
        JXAsyncs.asyncDelay(2, {
        }) {
            testLayer.removeFromSuperlayer()
        }
    }
    
    // MARK: 1.15、设置阴影圆角
    @objc func test115() {
        let testLayer = CALayer()
        testLayer.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        testLayer.backgroundColor = UIColor.randomColor.cgColor
        testLayer.shadowColor(.red)
        testLayer.shadowOpacity(0.68)
        testLayer.shadowOffset(CGSize(width: 1, height: 1))
        testLayer.shadowRadius(6)
        testLayer.addTo(self.view.layer)
        JXAsyncs.asyncDelay(2, {
        }) {
            testLayer.removeFromSuperlayer()
        }
    }
    
    // MARK: 1.16、高性能添加阴影 Shadow Path
    @objc func test116() {
        let testLayer = CALayer()
        testLayer.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        testLayer.backgroundColor = UIColor.randomColor.cgColor
        testLayer.shadowColor(.red)
        testLayer.shadowOpacity(0.68)
        testLayer.shadowRadius(6)
        // testLayer.shadowPath(UIBezierPath.init(rect: testLayer.bounds).cgPath)
        testLayer.addTo(self.view.layer)
        JXAsyncs.asyncDelay(2, {
        }) {
            testLayer.removeFromSuperlayer()
        }
    }
}
