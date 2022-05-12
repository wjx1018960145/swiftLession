//
//  UIViewExtensionViewController.swift
//  SwiftLession01
//
//  Created by wjx on 2022/4/29.
//

import UIKit
import WebKit
class UIViewExtensionViewController: TestBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        headDataArray = ["一、UIView 有关 Frame 的扩展", "二、继承于 UIView 视图的 平面、3D 旋转 以及 缩放", "三、关于UIView的 圆角 和 阴影的设置", "四、自定义链式编程", "五、其他的方法", "六、试图调试", "七、手势的扩展", "八、颜色渐变"]
        dataArray = [["x 的位置", "y 的位置", "height: 视图的高度", "width: 视图的宽度", "size: 视图的zize", "centerX: 视图的X中间位置", "centerX: 视图的Y中间位置", "center: 视图的中间位置", "top 上端横坐标(y)", "left 左端横坐标(x)", "bottom 底端纵坐标 (y + height)", "right 底端纵坐标 (x + width)"], ["平面旋转", "沿 X 轴方向旋转多少度(3D旋转)", "沿 Y 轴方向旋转多少度(3D旋转)", "沿 Z 轴方向旋转多少度(3D旋转)", "沿 X、Y、Z 轴方向同时旋转多少度(3D旋转)", "设置 x,y 缩放"], ["设置圆角", "添加阴影", "添加阴影和圆角并存", "添加边框", "添加顶部的边框", "添加顶部的 内边框", "添加底部的 边框", "添加左边的 边框", "添加右边的 边框", "画圆环", "绘制虚线", "添加内阴影"], ["设置tag值", "设置圆角", "图片的模式", "设置背景色", "设置十六进制颜色", "设置 frame", "被添加到某个视图上", "设置是否支持触摸", "设置是否隐藏", "设置透明度", "设置tintColor", "链式编程的综合使用"], ["获取当前view的viewcontroller", "添加水印", "将 View 转换成图片", "添加点击事件", "键盘收起来", "视图抖动", "是否包含WKWebView"], ["图层调试", "寻找某个类型子视图", "移除所有的子视图", "移除layer"], ["通用响应添加方法", "手势 - 单击", "手势 - 长按", "手势 - 拖拽", "手势 - 屏幕边缘(靠近屏幕边缘的View类才支持)", "手势 - 屏幕边缘(闭包)", "手势 - 清扫", "手势 - 清扫(闭包)", "手势 - 捏合", "手势 - 旋转"], ["添加渐变色图层（棕色->绿色）", "colors 变化渐变动画"]]
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
// MARK: - 八、颜色渐变
extension UIViewExtensionViewController {
    
    // MARK: 8.2、colors 变化渐变动画
    @objc func test82() {
        let testView = UIView(frame: CGRect(x: 0, y: 200, width: 260, height: 60))
        testView.backgroundColor = .randomColor
        testView.center.x = self.view.center.x
        testView.clipsToBounds = true
        self.view.addSubview(testView)
        testView.jx.gradientColorAnimation(startGradientColors: [UIColor.brown.cgColor, UIColor.green.cgColor], endGradientColors: [UIColor.yellow.cgColor, UIColor.purple.cgColor])
        JXAsyncs.asyncDelay(3) {
        } _: {
            testView.removeFromSuperview()
        }
    }
    
    // MARK: 8.1、添加渐变色图层（棕色->绿色）
    @objc func test81() {
        let testView = UIView(frame: CGRect(x: 0, y: 200, width: 260, height: 60))
        testView.backgroundColor = .randomColor
        testView.center.x = self.view.center.x
        testView.clipsToBounds = true
        testView.jx.gradientColor(.horizontal, [UIColor.brown.cgColor, UIColor.green.cgColor])
        self.view.addSubview(testView)
        JXAsyncs.asyncDelay(3) {
        } _: {
            testView.removeFromSuperview()
        }
    }
}

// MARK: - 七、手势的扩展
extension UIViewExtensionViewController {
    
    // MARK: 7.10、手势 - 旋转
    @objc func test710() {
        let testView = UIView(frame: CGRect(x: 200, y: 100, width: 200, height: 200))
        testView.backgroundColor = .randomColor
        testView.center.x = self.view.center.x
        testView.clipsToBounds = true
        self.view.addSubview(testView)
        testView.jx.addGestureRotation { (gestureRecognizer) in
            print("手势 - 旋转")
        }
        JXAsyncs.asyncDelay(5) {
            
        } _: {
            testView.removeFromSuperview()
        }
    }
    
    // MARK: 7.9、手势 - 捏合
    @objc func test79() {
        let testView = UIView(frame: CGRect(x: 200, y: 100, width: 200, height: 200))
        testView.backgroundColor = .randomColor
        testView.center.x = self.view.center.x
        testView.clipsToBounds = true
        self.view.addSubview(testView)
        testView.jx.addGesturePinch { (gestureRecognizer) in
            print("手势 - 捏合")
        }
        JXAsyncs.asyncDelay(5) {
            
        } _: {
            testView.removeFromSuperview()
        }
    }
    
    // MARK: 7.8、手势 - 清扫(闭包)
    @objc func test78() {
        let testView = UIView(frame: CGRect(x: 200, y: 100, width: 200, height: 200))
        testView.backgroundColor = .randomColor
        testView.center.x = self.view.center.x
        testView.clipsToBounds = true
        self.view.addSubview(testView)
        testView.jx.addGestureSwip({ (gestureRecognizer) in
            print("手势 - 清扫")
        }, for: .left)
        JXAsyncs.asyncDelay(5) {
            
        } _: {
            testView.removeFromSuperview()
        }
    }
    
    // MARK: 7.7、手势 - 清扫
    @objc func test77() {
        let testView = UIView(frame: CGRect(x: 200, y: 100, width: 200, height: 200))
        testView.backgroundColor = .randomColor
        testView.center.x = self.view.center.x
        testView.clipsToBounds = true
        self.view.addSubview(testView)
        testView.jx.addGestureSwip(self, action: #selector(swip), for: .right)
        JXAsyncs.asyncDelay(5) {
            
        } _: {
            testView.removeFromSuperview()
        }
    }
    
    @objc func swip() {
        print("手势 - 清扫")
    }
    
    // MARK: 7.6、手势 - 屏幕边缘(闭包)
    @objc func test76() {
        let testView = UIView(frame: CGRect(x: 0, y: 100, width: jx_kScreenW, height: 200))
        testView.backgroundColor = .randomColor
        testView.center.x = self.view.center.x
        testView.clipsToBounds = true
        self.view.addSubview(testView)
        testView.jx.addGestureEdgPan({ (gestureRecognizer) in
            print("手势 - 屏幕边缘")
        }, for: .right)
        JXAsyncs.asyncDelay(5) {
            
        } _: {
            testView.removeFromSuperview()
        }
    }
    
    // MARK: 7.5、手势 - 屏幕边缘
    @objc func test75() {
        self.view.jx.addGestureEdgPan(self, action: #selector(gestureEdgPan1), for: .right)
    }
    
    @objc func gestureEdgPan1() {
        print("手势 - 屏幕边缘")
    }
    
    // MARK: 7.4、手势 - 拖拽
    @objc func test74() {
        let testView = UIView(frame: CGRect(x: 200, y: 100, width: 200, height: 200))
        testView.backgroundColor = .randomColor
        testView.center.x = self.view.center.x
        testView.clipsToBounds = true
        self.view.addSubview(testView)
        
        testView.jx.addGesturePan { (gestureRecognizer) in
            print("手势 - 拖拽")
        }
        JXAsyncs.asyncDelay(5) {
            
        } _: {
            testView.removeFromSuperview()
        }
    }
    
    // MARK: 7.3、手势 - 长按
    @objc func test73() {
        let testView = UIView(frame: CGRect(x: 200, y: 100, width: 200, height: 200))
        testView.backgroundColor = .randomColor
        testView.center.x = self.view.center.x
        testView.clipsToBounds = true
        self.view.addSubview(testView)
        
        testView.jx.addGestureLongPress({ (gestureRecognizer) in
            print("长按2秒")
        }, for: 2)
        JXAsyncs.asyncDelay(5) {
            
        } _: {
            testView.removeFromSuperview()
        }
    }
    
    // MARK: 7.2、手势 - 单击
    @objc func test72() {
        let testView = UIView(frame: CGRect(x: 200, y: 100, width: 200, height: 200))
        testView.backgroundColor = .randomColor
        testView.center.x = self.view.center.x
        testView.clipsToBounds = true
        self.view.addSubview(testView)
        
        testView.jx.addGestureTap { (gestureRecognizer) in
            print("手势 - 单击")
        }
        JXAsyncs.asyncDelay(5) {
            
        } _: {
            testView.removeFromSuperview()
        }
    }
    
    // MARK: 7.1、通用响应添加方法
    @objc func test71() {
        let testView = UIView(frame: CGRect(x: 200, y: 100, width: 200, height: 200))
        testView.backgroundColor = .randomColor
        testView.center.x = self.view.center.x
        testView.clipsToBounds = true
        self.view.addSubview(testView)
        
        testView.jx.addActionClosure { (tapGestureRecognizer, view, integer) in
            print("点击了")
        }
        JXAsyncs.asyncDelay(5) {
            
        } _: {
            testView.removeFromSuperview()
        }
    }
}

// MARK: - 六、试图调试
extension UIViewExtensionViewController {
    
    // MARK: 6.4、移除layer
    @objc func test64() {
        let testView = UIView(frame: CGRect(x: 200, y: 100, width: 200, height: 200))
        testView.backgroundColor = .randomColor
        testView.center.x = self.view.center.x
        testView.clipsToBounds = true
        testView.layer.borderWidth = 20
        testView.layer.borderColor = UIColor.red.cgColor
        self.view.addSubview(testView)
        
        JXAsyncs.asyncDelay(3, {
        }) {
            testView.jx.removeLayer()
            JXAsyncs.asyncDelay(2, {
            }) {
                testView.removeFromSuperview()
            }
        }
    }
    
    // MARK: 6.3、移除所有的子视图
    @objc func test63() {
        let testView = UIView(frame: CGRect(x: 200, y: 100, width: 200, height: 200))
        testView.backgroundColor = .randomColor
        testView.center.x = self.view.center.x
        testView.clipsToBounds = true
        self.view.addSubview(testView)
        
        let testView1 = UIView(frame: CGRect(x: 0, y: 10, width: 20, height: 20))
        testView1.backgroundColor = .randomColor
        testView.addSubview(testView1)
        let testView2 = UIView(frame: CGRect(x: 100, y: 100, width: 20, height: 20))
        testView2.backgroundColor = .randomColor
        testView.addSubview(testView2)
        JXAsyncs.asyncDelay(3, {
        }) {
            testView.jx.removeAllSubViews()
            JXAsyncs.asyncDelay(2, {
            }) {
                testView.removeFromSuperview()
            }
        }
    }
    
    // MARK: 6.2、寻找某个类型子视图
    @objc func test62() {
        let testView = UIView(frame: CGRect(x: 200, y: 100, width: 200, height: 200))
        testView.backgroundColor = .randomColor
        testView.center.x = self.view.center.x
        testView.clipsToBounds = true
        self.view.addSubview(testView)
        
        let testView1 = UIView(frame: CGRect(x: 0, y: 10, width: 20, height: 20))
        testView1.backgroundColor = .randomColor
        testView.addSubview(testView1)
        let testView2 = UIView(frame: CGRect(x: 100, y: 100, width: 20, height: 20))
        testView2.backgroundColor = .randomColor
        testView.addSubview(testView2)
        if let resultView = testView.jx.findSubview(type: UIView.self, resursion: true) {
            print("寻找子视图:\(testView) 结果是：\(resultView)")
        } else {
            print("寻找子视图:\(testView) 结果是：false")
        }
        JXAsyncs.asyncDelay(2) {
            
        } _: {
            testView.removeFromSuperview()
        }

    }
    
    // MARK: 6.1、图层调试(兼容OC)
    @objc func test61() {
        self.view.jx.getViewLayer()
    }
}

// MARK: - 五、其他的方法
extension UIViewExtensionViewController {
    
    // MARK: 5.7、是否包含WKWebView
    @objc func test57() {
        let testView = UIView(frame: CGRect(x: 200, y: 100, width: 200, height: 200))
        testView.backgroundColor = .randomColor
        testView.center.x = self.view.center.x
        testView.clipsToBounds = true
        self.view.addSubview(testView)
        
        let wkwebView = WKWebView(frame: CGRect(x: 10, y: 10, width: 50, height: 50))
        wkwebView.backgroundColor = .randomColor
        testView.addSubview(wkwebView)
        
        print("视图是否包含WKWebView：\(testView.jx.isContainsWKWebView())")
        
        JXAsyncs.asyncDelay(2) {
        } _: {
            testView.removeFromSuperview()
        }
    }
    
    // MARK: 5.6、视图抖动
    @objc func test56() {
        let testView = UIView(frame: CGRect(x: 200, y: 100, width: 200, height: 200))
        testView.backgroundColor = .randomColor
        testView.center.x = self.view.center.x
        testView.clipsToBounds = true
        self.view.addSubview(testView)
        
        JXAsyncs.asyncDelay(2) {
        } _: {
            testView.jx.shake(direction: .horizontal, times: 3, interval: 0.1, delta: 2) {
                JXAsyncs.asyncDelay(2) {
                } _: {
                    testView.jx.shake(direction: .vertical, times: 3, interval: 0.1, delta: 2) {
                        JXAsyncs.asyncDelay(2) {
                        } _: {
                            testView.removeFromSuperview()
                        }
                    }
                }
            }
        }
    }
    
    // MARK: 5.5、键盘收起来
    @objc func test55() {
        self.view.jx.keyboardEndEditing()
    }

    // MARK: 5.4、添加点击事件
    @objc func test54() {
        let testView = UIView(frame: CGRect(x: 200, y: 100, width: 200, height: 200))
        testView.backgroundColor = .randomColor
        testView.center.x = self.view.center.x
        testView.clipsToBounds = true
        testView.jx.addTapGestureRecognizerAction(self, #selector(click))
        self.view.addSubview(testView)
        
        JXAsyncs.asyncDelay(5) {
        } _: {
            testView.removeFromSuperview()
        }
    }
    
    // 测试
    @objc func click() {
        print("测试---添加点击事件")
    }
    
    // MARK: 5.3、将 View 转换成图片
    @objc func test53() {
        let testView = UIView(frame: CGRect(x: 200, y: 100, width: 200, height: 200))
        testView.backgroundColor = .randomColor
        testView.center.x = self.view.center.x
        testView.clipsToBounds = true
        self.view.addSubview(testView)
        
        let testView1 = UIView(frame: CGRect(x: 0, y: 10, width: 20, height: 20))
        testView1.backgroundColor = .randomColor
        testView.addSubview(testView1)
        let testView2 = UIView(frame: CGRect(x: 100, y: 100, width: 20, height: 20))
        testView2.backgroundColor = .randomColor
        testView.addSubview(testView2)
        
        let gifImageView = UIImageView(frame: CGRect(x: 100, y: testView.jx.bottom + 50, width: 200,height: 200))
        self.view.addSubview(gifImageView)
        
        guard let image = testView.jx.toImage() else {
            print("view转换image失败")
            return
        }
        
        JXAsyncs.asyncDelay(3, {
        }) {
            gifImageView.image = image
            JXAsyncs.asyncDelay(2, {
            }) {
                testView.removeFromSuperview()
                gifImageView.removeFromSuperview()
            }
        }
    }
    
    // MARK: 5.2、添加水印
    @objc func test52() {
        let testView = UIView(frame: CGRect(x: 200, y: 100, width: 200, height: 200))
        testView.backgroundColor = .randomColor
        testView.center.x = self.view.center.x
        testView.clipsToBounds = true
        testView.jx.addWater(markText: "这是水印", textColor: .red, font: .systemFont(ofSize: 19))
        self.view.addSubview(testView)
        JXAsyncs.asyncDelay(3, {
        }) {
            testView.removeFromSuperview()
        }
    }
    
    // MARK: 5.1、获取当前view的viewcontroller
    @objc func test51() {
        let testView = UIView(frame: CGRect(x: 200, y: 100, width: 100, height: 100))
        testView.backgroundColor = .randomColor
        self.view.addSubview(testView)
        guard let vc = testView.jx.currentVC else {
            return
        }
        JXAsyncs.asyncDelay(1, {
            print("获取当前view的viewcontroller：\(vc.className)")
        }) {
            testView.removeFromSuperview()
        }
    }
}

// MARK: - 四、自定义链式编程
extension UIViewExtensionViewController {
    
    // MARK: 4.1、设置tag值
    @objc func test41() {
        let testView = UIView(frame: CGRect(x: 200, y: 100, width: 100, height: 100))
        testView.tag(108)
        testView.backgroundColor = .randomColor
        self.view.addSubview(testView)
        UIView.animate(withDuration: 2, animations: {
            print("tag值：\(testView.tag)")
        }) { (result) in
            testView.removeFromSuperview()
        }
    }
    
    // MARK: 4.2、设置圆角
    @objc func test42() {
        let testView = UIView(frame: CGRect(x: 200, y: 100, width: 100, height: 100))
        testView.corner(22)
        testView.backgroundColor = .randomColor
        self.view.addSubview(testView)
        JXAsyncs.asyncDelay(3, {
        }) {
            testView.removeFromSuperview()
        }
    }
    
    // MARK: 4.3、图片的模式
    @objc func test43() {
        var testImageView = UIImageView(frame: CGRect(x: 0, y: 100, width: 200, height: 300))
        testImageView.jx.centerX = self.view.jx.centerX
        testImageView.image = UIImage(named: "testicon")
        testImageView.contentMode(.scaleAspectFill)
        testImageView.backgroundColor = .randomColor
        self.view.addSubview(testImageView)
        JXAsyncs.asyncDelay(3, {
        }) {
            testImageView.removeFromSuperview()
        }
    }
    
    // MARK: 4.4、设置背景色
    @objc func test44() {
        let testView = UIView(frame: CGRect(x: 200, y: 100, width: 100, height: 100))
        testView.backgroundColor(.brown)
        self.view.addSubview(testView)
        JXAsyncs.asyncDelay(3, {
        }) {
            testView.removeFromSuperview()
        }
    }
    
    // MARK: 4.5、设置十六进制颜色
    @objc func test45() {
        let testView = UIView(frame: CGRect(x: 200, y: 100, width: 100, height: 100))
        testView.backgroundColor("#008000")
        self.view.addSubview(testView)
        JXAsyncs.asyncDelay(3, {
        }) {
            testView.removeFromSuperview()
        }
    }
    
    // MARK: 4.6、设置 frame
    @objc func test46() {
        let testView = UIView(frame: CGRect(x: 200, y: 100, width: 100, height: 100))
        testView.backgroundColor = .randomColor
        self.view.addSubview(testView)
        JXAsyncs.asyncDelay(2, {
        }) {
            testView.frame = CGRect(x: 200, y: 100, width: 50, height: 50)
            JXAsyncs.asyncDelay(2, {
            }) {
                testView.removeFromSuperview()
            }
        }
    }
    
    // MARK: 4.7、被添加到某个视图上
    @objc func test47() {
        let testView = UIView(frame: CGRect(x: 200, y: 100, width: 100, height: 100))
        testView.backgroundColor = .randomColor
        testView.addTo(self.view)
        JXAsyncs.asyncDelay(2, {
        }) {
            testView.removeFromSuperview()
        }
    }
    
    // MARK: 4.8、设置是否支持触摸
    @objc func test48() {
        let testView = UIView(frame: CGRect(x: 200, y: 100, width: 100, height: 100))
        testView.backgroundColor = .randomColor
        testView.isUserInteractionEnabled(true)
        self.view.addSubview(testView)
        JXAsyncs.asyncDelay(2, {
        }) {
            testView.removeFromSuperview()
        }
    }
    
    // MARK: 4.9、设置是否隐藏
    @objc func test49() {
        let testView = UIView(frame: CGRect(x: 200, y: 100, width: 100, height: 100))
        testView.backgroundColor = .randomColor
        testView.isHidden(false)
        self.view.addSubview(testView)
        JXAsyncs.asyncDelay(2, {
        }) {
            testView.removeFromSuperview()
        }
    }
    
    // MARK: 4.10、设置透明度
    @objc func test410() {
        let testView = UIView(frame: CGRect(x: 200, y: 100, width: 100, height: 100))
        testView.backgroundColor = .randomColor
        testView.alpha(0.6)
        self.view.addSubview(testView)
        JXAsyncs.asyncDelay(2, {
        }) {
            testView.removeFromSuperview()
        }
    }
    
    // MARK: 4.11、设置tintColor
    @objc func test411() {
        let testView1 = UILabel(frame: CGRect(x: 200, y: 100, width: 100, height: 400))
        testView1.backgroundColor = .brown
        testView1.text = "2秒后消失"
        testView1.tintColor = .yellow
        testView1.addTo(self.view)
        let testView2 = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        testView2.backgroundColor = .green
        testView2.text = "2秒后消失"
        testView1.addSubview(testView2)
        JXAsyncs.asyncDelay(2, {
        }) {
            testView1.removeFromSuperview()
        }
    }
    
    // MARK: 4.12、链式编程的综合使用
    @objc func test412() {
        let testView1 = UILabel().frame(CGRect(x: 100, y: 100, width: 100, height: 100)).backgroundColor(.green).isUserInteractionEnabled(true).tag(101).corner(10).addTo(self.view)
        JXAsyncs.asyncDelay(2, {
        }) {
            testView1.removeFromSuperview()
        }
    }
}

// MARK: - 三、关于UIView的 圆角 和 阴影的设置
extension UIViewExtensionViewController {
    
    // MARK: 3.1、设置圆角
    @objc func test31() {
        var testView = UILabel(frame: CGRect(x: 0, y: 100, width: 200, height: 100))
        testView.backgroundColor = .randomColor
        testView.text = "2秒后消失"
        testView.textAlignment = .center
        testView.textColor = .randomColor
        testView.jx.centerX = self.view.jx.centerX
        testView.jx.addShadow(shadowColor: UIColor.black.withAlphaComponent(0.48), shadowOffset: CGSize(width: 1.0, height: 1.0), shadowOpacity: 1, shadowRadius: 20)
        testView.jx.addCorner(conrners: [.topLeft], radius: 20)
        self.view.addSubview(testView)
        JXAsyncs.asyncDelay(2, {
        }) {
           testView.removeFromSuperview()
        }
    }
    
    // MARK: 3.2、添加阴影
    @objc func test32() {
        var testView = UILabel(frame: CGRect(x: 0, y: 100, width: 200, height: 100))
        testView.backgroundColor = .randomColor
        testView.text = "2秒后消失"
        testView.textAlignment = .center
        testView.textColor = .randomColor
        testView.jx.centerX = self.view.jx.centerX
        testView.jx.addShadow(shadowColor: UIColor.black.withAlphaComponent(0.48), shadowOffset: CGSize(width: 1.0, height: 1.0), shadowOpacity: 1, shadowRadius: 20)
        self.view.addSubview(testView)
        JXAsyncs.asyncDelay(2, {
        }) {
           testView.removeFromSuperview()
        }
    }
    
    // MARK: 3.3、添加 圆角 和 阴影
    @objc func test33() {
        
        var testView = UIView(frame: CGRect(x: 0, y: 100, width: 300, height: 200))
        testView.backgroundColor = .randomColor
        testView.jx.centerX = self.view.jx.centerX
        testView.layer.cornerRadius = 6
        testView.clipsToBounds = false
        self.view.addSubview(testView)
        
        let testLabel = UILabel(frame: CGRect(x: 50, y: 50, width: 200, height: 100))
        testLabel.backgroundColor = .randomColor
        testLabel.text = "2秒后消失"
        testLabel.textAlignment = .center
        testLabel.textColor = .randomColor
        testLabel.jx.addCornerAndShadow(superview: testView, conrners: [.allCorners], radius: 6, shadowColor: UIColor.black.withAlphaComponent(0.48), shadowOffset: CGSize(width: 1.0, height: 1.0), shadowOpacity: 1, shadowRadius: 6)
        testView.addSubview(testLabel)
        JXAsyncs.asyncDelay(2, {
        }) {
           testView.removeFromSuperview()
        }
    }
    
    // MARK: 3.4、添加边框
    @objc func test34() {
        var testView = UILabel(frame: CGRect(x: 0, y: 100, width: 200, height: 100))
        testView.backgroundColor = .randomColor
        testView.text = "2秒后消失"
        testView.textAlignment = .center
        testView.textColor = .randomColor
        testView.jx.centerX = self.view.jx.centerX
        testView.jx.addBorder(borderWidth: 10, borderColor: .red)
        self.view.addSubview(testView)
        JXAsyncs.asyncDelay(2, {
        }) {
           testView.removeFromSuperview()
        }
    }
    
    // MARK: 3.5、添加顶部的边框
    @objc func test35() {
        var testView = UILabel(frame: CGRect(x: 0, y: 100, width: 200, height: 100))
        testView.backgroundColor = .randomColor
        testView.text = "2秒后消失"
        testView.textAlignment = .center
        testView.textColor = .randomColor
        testView.jx.centerX = self.view.jx.centerX
        testView.jx.addBorderTop(borderWidth: 10, borderColor: .red)
        self.view.addSubview(testView)
        JXAsyncs.asyncDelay(2, {
        }) {
           testView.removeFromSuperview()
        }
    }
    
    // MARK: 3.6、添加顶部的 内边框
    @objc func test36() {
        var testView = UILabel(frame: CGRect(x: 0, y: 100, width: 200, height: 100))
        testView.backgroundColor = .randomColor
        testView.text = "2秒后消失"
        testView.textAlignment = .center
        testView.textColor = .randomColor
        testView.jx.centerX = self.view.jx.centerX
        testView.jx.addBorderTopWithPadding(borderWidth: 40, borderColor: .brown, padding: 8)
        self.view.addSubview(testView)
        JXAsyncs.asyncDelay(2, {
        }) {
           testView.removeFromSuperview()
        }
    }
    
    // MARK: 3.7、添加底部的 边框
    @objc func test37() {
        var testView = UILabel(frame: CGRect(x: 0, y: 100, width: 200, height: 100))
        testView.backgroundColor = .randomColor
        testView.text = "2秒后消失"
        testView.textAlignment = .center
        testView.textColor = .randomColor
        testView.jx.centerX = self.view.jx.centerX
        testView.jx.addBorderBottom(borderWidth: 20, borderColor: .brown)
        self.view.addSubview(testView)
        JXAsyncs.asyncDelay(2, {
        }) {
           testView.removeFromSuperview()
        }
    }
    
    // MARK: 3.8、添加左边的 边框
    @objc func test38() {
        var testView = UILabel(frame: CGRect(x: 0, y: 100, width: 200, height: 100))
        testView.backgroundColor = .randomColor
        testView.text = "2秒后消失"
        testView.textAlignment = .center
        testView.textColor = .randomColor
        testView.jx.centerX = self.view.jx.centerX
        testView.jx.addBorderLeft(borderWidth: 20, borderColor: .brown)
        self.view.addSubview(testView)
        JXAsyncs.asyncDelay(2, {
        }) {
           testView.removeFromSuperview()
        }
    }
    
    // MARK: 3.9、添加右边的 边框
    @objc func test39() {
        var testView = UILabel(frame: CGRect(x: 0, y: 100, width: 200, height: 100))
        testView.backgroundColor = .randomColor
        testView.text = "2秒后消失"
        testView.textAlignment = .center
        testView.textColor = .randomColor
        testView.jx.centerX = self.view.jx.centerX
        testView.jx.addBorderRight(borderWidth: 20, borderColor: .brown)
        self.view.addSubview(testView)
        JXAsyncs.asyncDelay(2, {
        }) {
           testView.removeFromSuperview()
        }
    }
    
    // MARK: 3.10、画圆环
    @objc func test310() {
        var testView = UILabel(frame: CGRect(x: 0, y: 100, width: 200, height: 100))
        testView.backgroundColor = .randomColor
        testView.text = "2秒后消失"
        testView.textAlignment = .center
        testView.textColor = .randomColor
        testView.jx.centerX = self.view.jx.centerX
        testView.jx.drawCircle(fillColor: .red, strokeColor: .blue, strokeWidth: 10)
        self.view.addSubview(testView)
        JXAsyncs.asyncDelay(2, {
        }) {
           testView.removeFromSuperview()
        }
    }
    
    // MARK: 3.11、绘制虚线
    @objc func test311() {
        let backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 500))
        backgroundView.center = self.view.center
        backgroundView.backgroundColor = .brown
        self.view.addSubview(backgroundView)
        
        let lineView = UIView(frame: CGRect(x: 20, y: 20, width: 200, height: 2))
        // lineView.backgroundColor = .yellow
        lineView.jx.drawDashLine(strokeColor: UIColor.red, lineLength: 4, lineSpacing: 4, direction: .horizontal)
        backgroundView.addSubview(lineView)
        
        let lineView2 = UIView(frame: CGRect(x: 60, y: 130, width: 2, height: 200))
        // lineView2.backgroundColor = .yellow
        lineView2.jx.drawDashLine(strokeColor: UIColor.red, lineLength: 4, lineSpacing: 3, direction: .vertical)
        backgroundView.addSubview(lineView2)
        
        JXAsyncs.asyncDelay(2, {
        }) {
            backgroundView.removeFromSuperview()
        }
    }
    
    // MARK: 3.12、添加内阴影
    @objc func test312() {
        let backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 500))
        backgroundView.center = self.view.center
        backgroundView.backgroundColor = .white
        backgroundView.layer.cornerRadius = 20
        backgroundView.clipsToBounds = true
        self.view.addSubview(backgroundView)
        
        
        backgroundView.jx.addInnerShadowLayer(shadowColor: UIColor.brown, shadowOffset: CGSize(width: 0, height: 0), shadowOpacity: 0.5, shadowRadius: 10, insetBySize: CGSize(width: -42, height: -42))
        
        JXAsyncs.asyncDelay(3, {
        }) {
            backgroundView.removeFromSuperview()
        }
    }
}

// MARK: - 二、继承于 UIView 视图的 平面、3D 旋转 以及 缩放
extension UIViewExtensionViewController {
    
    // MARK: 2.1、沿 X 轴方向旋转多少度
    @objc func test21() {
        let testView = UIView(frame: CGRect(x: 200, y: 100, width: 100, height: 100))
        testView.backgroundColor = .randomColor
        let testView2 = UIView(frame: CGRect(x: 0, y: 80, width: 100, height: 20))
        testView2.backgroundColor = .randomColor
        testView.addSubview(testView2)
        self.view.addSubview(testView)
        UIView.animate(withDuration: 2, animations: {
            testView.jx.set3DRotationX(CGFloat.pi)
        }) { (result) in
            testView.removeFromSuperview()
        }
    }
    
    // MARK: 2.2、沿 X 轴方向旋转多少度(3D旋转)
    @objc func test22() {
        let testView = UIView(frame: CGRect(x: 200, y: 100, width: 100, height: 100))
        testView.backgroundColor = .randomColor
        let testView2 = UIView(frame: CGRect(x: 0, y: 80, width: 100, height: 20))
        testView2.backgroundColor = .randomColor
        //testView.addSubview(testView2)
        self.view.addSubview(testView)
        UIView.animate(withDuration: 2, animations: {
            testView.jx.set3DRotationX(CGFloat.pi)
        }) { (result) in
            testView.removeFromSuperview()
        }
    }
    
    // MARK: 2.3、沿 Y 轴方向旋转多少度(3D旋转)
    @objc func test23() {
        let testView = UIView(frame: CGRect(x: 200, y: 100, width: 100, height: 100))
        testView.backgroundColor = .randomColor
        let testView2 = UIView(frame: CGRect(x: 0, y: 80, width: 100, height: 20))
        testView2.backgroundColor = .randomColor
        testView.addSubview(testView2)
        self.view.addSubview(testView)
        UIView.animate(withDuration: 2, animations: {
            testView.jx.set3DRotationY(CGFloat.pi)
        }) { (result) in
            testView.removeFromSuperview()
        }
    }
    
    // MARK: 2.4、沿 Z 轴方向旋转多少度(3D旋转)
    @objc func test24() {
        let testView = UIView(frame: CGRect(x: 200, y: 100, width: 100, height: 100))
        testView.backgroundColor = .randomColor
        let testView2 = UIView(frame: CGRect(x: 0, y: 80, width: 100, height: 20))
        testView2.backgroundColor = .randomColor
        testView.addSubview(testView2)
        self.view.addSubview(testView)
        UIView.animate(withDuration: 2, animations: {
            testView.jx.set3DRotationZ(CGFloat.pi)
        }) { (result) in
            testView.removeFromSuperview()
        }
    }
    
    // MARK: 2.5、沿 X、Y、Z 轴方向同时旋转多少度(3D旋转)
    @objc func test25() {
        
        let testView = UIView(frame: CGRect(x: 200, y: 100, width: 100, height: 100))
        testView.backgroundColor = .randomColor
        let testView2 = UIView(frame: CGRect(x: 0, y: 80, width: 100, height: 20))
        testView2.backgroundColor = .randomColor
        testView.addSubview(testView2)
        self.view.addSubview(testView)
        UIView.animate(withDuration: 2, animations: {
            testView.jx.setRotation(xAngle: CGFloat.pi, yAngle: CGFloat.pi/2, zAngle: CGFloat.pi / 2)
        }) { (result) in
            testView.removeFromSuperview()
        }
    }
    
    // MARK: 2.5、设置 x,y 缩放
    @objc func test26() {
        
        let testView = UIView(frame: CGRect(x: 200, y: 100, width: 100, height: 100))
        testView.backgroundColor = .randomColor
        let testView2 = UIView(frame: CGRect(x: 0, y: 80, width: 100, height: 20))
        testView2.backgroundColor = .randomColor
        testView.addSubview(testView2)
        self.view.addSubview(testView)
        UIView.animate(withDuration: 2, animations: {
            testView.jx.setScale(x: 2, y: 2)
        }) { (result) in
            testView.removeFromSuperview()
        }
    }
}

// MARK: - 一、UIView 有关 Frame 的扩展
extension UIViewExtensionViewController {
    
    // MARK: 1.1、x 的位置
    @objc func test11() {
        var testView = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        testView.backgroundColor = .randomColor
        self.view.addSubview(testView)
        UIView.animate(withDuration: 2, animations: {
            testView.jx.x = 150
        }) { (result) in
            testView.removeFromSuperview()
        }
    }
    
    // MARK: 1.2、y 的位置
    @objc func test12() {
       var testView = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
       testView.backgroundColor = .randomColor
       self.view.addSubview(testView)
       UIView.animate(withDuration: 2, animations: {
           testView.jx.y = 150
       }) { (result) in
           testView.removeFromSuperview()
       }
    }
    
    // MARK: 1.3、height: 视图的高度
    @objc func test13() {
       var testView = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
       testView.backgroundColor = .randomColor
       self.view.addSubview(testView)
       UIView.animate(withDuration: 2, animations: {
           testView.jx.height = 150
       }) { (result) in
           testView.removeFromSuperview()
       }
    }
    
    // MARK: 1.4、width: 视图的宽度
    @objc func test14() {
       var testView = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
       testView.backgroundColor = .randomColor
       self.view.addSubview(testView)
       UIView.animate(withDuration: 2, animations: {
           testView.jx.width = 150
       }) { (result) in
           testView.removeFromSuperview()
       }
    }
    
    // MARK: 1.5、size: 视图的zize
    @objc func test15() {
        var testView = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        testView.backgroundColor = .randomColor
        self.view.addSubview(testView)
        UIView.animate(withDuration: 2, animations: {
            testView.jx.size = CGSize(width: 150, height: 150)
        }) { (result) in
            testView.removeFromSuperview()
        }
    }
    
    // MARK: 1.6、centerX: 视图的X中间位置
    @objc func test16() {
        var testView = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        testView.backgroundColor = .randomColor
        self.view.addSubview(testView)
        UIView.animate(withDuration: 2, animations: {
            testView.jx.centerX = 200
        }) { (result) in
            testView.removeFromSuperview()
        }
    }
    
    // MARK: 1.7、centerY: 视图的Y中间位置
    @objc func test17() {
        var testView = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        testView.backgroundColor = .randomColor
        self.view.addSubview(testView)
        UIView.animate(withDuration: 2, animations: {
            testView.jx.centerY = 200
        }) { (result) in
            testView.removeFromSuperview()
        }
    }
    
    // MARK: 1.8、center: 视图的中间位置
    @objc func test18() {
        var testView = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        testView.backgroundColor = .randomColor
        self.view.addSubview(testView)
        UIView.animate(withDuration: 2, animations: {
            testView.jx.center = CGPoint(x: 100, y: 250)
        }) { (result) in
            testView.removeFromSuperview()
        }
    }
    
    // MARK: 1.9、top 上端横坐标(y)
    @objc func test19() {
        var testView = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        testView.backgroundColor = .randomColor
        self.view.addSubview(testView)
        UIView.animate(withDuration: 2, animations: {
            testView.jx.top = 300
        }) { (result) in
            testView.removeFromSuperview()
        }
    }
    
    // MARK: 1.10、left 左端横坐标(x)
    @objc func test110() {
        var testView = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        testView.backgroundColor = .randomColor
        self.view.addSubview(testView)
        UIView.animate(withDuration: 2, animations: {
            testView.jx.left = 250
        }) { (result) in
            testView.removeFromSuperview()
        }
    }
    
    // MARK: 1.11、bottom 底端纵坐标 (y + height)
    @objc func test111() {
        var testView = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        testView.backgroundColor = .randomColor
        self.view.addSubview(testView)
        UIView.animate(withDuration: 2, animations: {
            testView.jx.bottom = 250
        }) { (result) in
            testView.removeFromSuperview()
        }
    }
    
    // MARK: 1.12、right 底端纵坐标 (x + width)
    @objc func test112() {
        var testView = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        testView.backgroundColor = .randomColor
        self.view.addSubview(testView)
        UIView.animate(withDuration: 2, animations: {
            testView.jx.right = jx_kScreenW - 20
        }) { (result) in
            testView.removeFromSuperview()
        }
    }
}

