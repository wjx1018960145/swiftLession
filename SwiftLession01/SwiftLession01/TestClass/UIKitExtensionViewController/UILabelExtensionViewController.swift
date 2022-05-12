//
//  UILabelExtensionViewController.swift
//  SwiftLession01
//
//  Created by wjx on 2022/4/19.
//

import UIKit

class UILabelExtensionViewController: TestBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        headDataArray = ["一、链式编程", "二、其他的基本扩展", "三、特定区域和特定文字的基本扩展"]
        dataArray = [["设置文字", "设置文字行数", "设置文字对齐方式", "设置富文本文字", "设置文本颜色", "设置文本颜色（十六进制字符串）", "设置字体的大小", "设置字体的大小", "设置字体的大小（粗体）"], ["获取已知 frame 的 label 的文本行数 & 每一行内容", "获取已知 width 的 label 的文本行数 & 每一行内容", "获取第一行内容", "改变行间距", "改变字间距", "改变字间距和行间距", "添加中划线"], ["设置特定区域的字体大小", "设置特定文字的字体大小", "设置特定区域的字体颜色", "设置特定文字的字体颜色", "设置行间距", "设置特定文字区域的下划线", "设置特定文字的下划线", "设置特定区域的删除线", "设置特定文字的删除线", "插入图片", "首行缩进", "设置特定文字区域的倾斜", "设置特定文字的倾斜"]]
        // Do any additional setup after loading the view.
    }
    @objc func click(sender: UIButton) {
       print("点击事件")
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

// MARK: - 三、特定区域和特定文字的基本扩展
extension UILabelExtensionViewController {
    
    // MARK: 3.13、设置特定文字的倾斜
    @objc func test313() {
        let testLabel = UILabel(frame: CGRect(x: 50, y: 100, width: 200, height: 300))
        testLabel.backgroundColor = .brown
        testLabel.numberOfLines = 0
        testLabel.font = UIFont.systemFont(ofSize: 20)
        testLabel.text("梅花以它弱小娇艳的身躯，凌寒傲雪，傲然绽放，装点着寂寞荒凉的冬日")
        self.view.addSubview(testLabel)
        JXAsyncs.asyncDelay(2, {
        }) {
            testLabel.jx.setSpecificTextBliqueness("傲雪", inclination: 0.3)
            JXAsyncs.asyncDelay(5, {
            }) {
                testLabel.removeFromSuperview()
            }
        }
    }
    
    // MARK: 3.12、设置特定文字区域的倾斜
    @objc func test312() {
        let testLabel = UILabel(frame: CGRect(x: 50, y: 100, width: 200, height: 300))
        testLabel.backgroundColor = .brown
        testLabel.numberOfLines = 0
        testLabel.font = UIFont.systemFont(ofSize: 20)
        testLabel.text("梅花以它弱小娇艳的身躯，凌寒傲雪，傲然绽放，装点着寂寞荒凉的冬日")
        self.view.addSubview(testLabel)
        JXAsyncs.asyncDelay(2, {
        }) {
            testLabel.jx.setSpecificRangeBliqueness(inclination: 0.5, range: NSRange(location: 2, length: 3))
            JXAsyncs.asyncDelay(5, {
            }) {
                testLabel.removeFromSuperview()
            }
        }
    }
    
    // MARK: 3.11、首行缩进
    @objc func test311() {
        let testLabel = UILabel(frame: CGRect(x: 50, y: 100, width: 200, height: 300))
        testLabel.backgroundColor = .brown
        testLabel.numberOfLines = 0
        testLabel.font = UIFont.systemFont(ofSize: 20)
        testLabel.text("梅花以它弱小娇艳的身躯，凌寒傲雪，傲然绽放，装点着寂寞荒凉的冬日")
        self.view.addSubview(testLabel)
        JXAsyncs.asyncDelay(2, {
        }) {
            testLabel.jx.firstLineLeftEdge(20)
            JXAsyncs.asyncDelay(5, {
            }) {
                testLabel.removeFromSuperview()
            }
        }
    }
    
    // MARK: 3.10、插入图片
    @objc func test310() {
        let testLabel = UILabel(frame: CGRect(x: 50, y: 100, width: 200, height: 300))
        testLabel.backgroundColor = .brown
        testLabel.numberOfLines = 0
        testLabel.font = UIFont.systemFont(ofSize: 20)
        testLabel.text("梅花以它弱小娇艳的身躯，凌寒傲雪，傲然绽放，装点着寂寞荒凉的冬日")
        self.view.addSubview(testLabel)
        JXAsyncs.asyncDelay(2, {
        }) {
            testLabel.jx.insertImage(imgName: "good6", imgBounds: CGRect(x: 0, y: -4, width: 20, height: 20), imgIndex: 5)
            testLabel.jx.insertImage(imgName: "good8", imgBounds: CGRect.zero, imgIndex: 10)
            JXAsyncs.asyncDelay(3, {
            }) {
                testLabel.removeFromSuperview()
            }
        }
    }
    
    // MARK: 3.9、设置特定文字的删除线
    @objc func test39() {
        let testLabel = UILabel(frame: CGRect(x: 50, y: 100, width: 200, height: 300))
        testLabel.backgroundColor = .brown
        testLabel.numberOfLines = 0
        testLabel.font = UIFont.systemFont(ofSize: 15)
        testLabel.text("梅花以它弱小娇艳的身躯，凌寒傲雪，傲然绽放，装点着寂寞荒凉的冬日")
        self.view.addSubview(testLabel)
        JXAsyncs.asyncDelay(2, {
        }) {
            testLabel.jx.setSpecificTextDeleteLine("的", color: .green)
            JXAsyncs.asyncDelay(3, {
            }) {
                testLabel.removeFromSuperview()
            }
        }
    }
    
    // MARK: 3.8、设置特定区域的删除线
    @objc func test38() {
        let testLabel = UILabel(frame: CGRect(x: 50, y: 100, width: 200, height: 300))
        testLabel.backgroundColor = .brown
        testLabel.numberOfLines = 0
        testLabel.font = UIFont.systemFont(ofSize: 15)
        testLabel.text("梅花以它弱小娇艳的身躯，凌寒傲雪，傲然绽放，装点着寂寞荒凉的冬日")
        self.view.addSubview(testLabel)
        JXAsyncs.asyncDelay(2, {
        }) {
            testLabel.jx.setSpecificRangeDeleteLine(color: .yellow, range: NSRange(location: 3, length: 17))
            JXAsyncs.asyncDelay(3, {
            }) {
                testLabel.removeFromSuperview()
            }
        }
    }
    
    // MARK: 3.7、设置特定文字的下划线
    @objc func test37() {
        let testLabel = UILabel(frame: CGRect(x: 50, y: 100, width: 200, height: 300))
        testLabel.backgroundColor = .brown
        testLabel.numberOfLines = 0
        testLabel.font = UIFont.systemFont(ofSize: 15)
        testLabel.text("梅花以它弱小娇艳的身躯，凌寒傲雪，傲然绽放，装点着寂寞荒凉的冬日")
        self.view.addSubview(testLabel)
        JXAsyncs.asyncDelay(2, {
        }) {
            testLabel.jx.setSpecificTextUnderLine("的", color: .blue)
            JXAsyncs.asyncDelay(3, {
            }) {
                testLabel.removeFromSuperview()
            }
        }
    }
    
    // MARK: 3.6、设置特定文字区域的下划线
    @objc func test36() {
        let testLabel = UILabel(frame: CGRect(x: 50, y: 100, width: 200, height: 300))
        testLabel.backgroundColor = .brown
        testLabel.numberOfLines = 0
        testLabel.font = UIFont.systemFont(ofSize: 15)
        testLabel.text("梅花以它弱小娇艳的身躯，凌寒傲雪，傲然绽放，装点着寂寞荒凉的冬日")
        self.view.addSubview(testLabel)
        JXAsyncs.asyncDelay(2, {
        }) {
            testLabel.jx.setSpecificRangeTextUnderLine(color: .green, range: NSRange(location: 3, length: 16))
            JXAsyncs.asyncDelay(3, {
            }) {
                testLabel.removeFromSuperview()
            }
        }
    }
    
    // MARK: 3.5、设置行间距
    @objc func test35() {
        let testLabel = UILabel(frame: CGRect(x: 50, y: 100, width: 200, height: 300))
        testLabel.backgroundColor = .brown
        testLabel.numberOfLines = 0
        testLabel.font = UIFont.systemFont(ofSize: 15)
        testLabel.text("梅花以它弱小娇艳的身躯，凌寒傲雪，傲然绽放，装点着寂寞荒凉的冬日")
        self.view.addSubview(testLabel)
        JXAsyncs.asyncDelay(2, {
        }) {
            testLabel.jx.setTextLineSpace(20)
            JXAsyncs.asyncDelay(3, {
            }) {
                testLabel.removeFromSuperview()
            }
        }
    }
    
    // MARK: 3.4、设置特定文字的字体颜色
    @objc func test34() {
        let testLabel = UILabel(frame: CGRect(x: 50, y: 100, width: 200, height: 300))
        testLabel.backgroundColor = .brown
        testLabel.numberOfLines = 0
        testLabel.font = UIFont.systemFont(ofSize: 15)
        testLabel.text("梅花以它弱小娇艳的身躯，凌寒傲雪，傲然绽放，装点着寂寞荒凉的冬日")
        self.view.addSubview(testLabel)
        JXAsyncs.asyncDelay(2, {
        }) {
            testLabel.jx.setSpecificTextColor("的", color: .green)
            JXAsyncs.asyncDelay(3, {
            }) {
                testLabel.removeFromSuperview()
            }
        }
    }
    
    // MARK: 3.3、设置特定区域的字体颜色
    @objc func test33() {
        let testLabel = UILabel(frame: CGRect(x: 50, y: 100, width: 200, height: 300))
        testLabel.backgroundColor = .brown
        testLabel.numberOfLines = 0
        testLabel.font = UIFont.systemFont(ofSize: 15)
        testLabel.text("梅花以它弱小娇艳的身躯，凌寒傲雪，傲然绽放，装点着寂寞荒凉的冬日")
        self.view.addSubview(testLabel)
        JXAsyncs.asyncDelay(2, {
        }) {
            testLabel.jx.setSpecificRangeTextColor(color: .red, range: NSRange(location: 5, length: 5))
            JXAsyncs.asyncDelay(3, {
            }) {
                testLabel.removeFromSuperview()
            }
        }
    }
    
    // MARK: 3.2、设置特定文字的字体大小
    @objc func test32() {
        let testLabel = UILabel(frame: CGRect(x: 50, y: 100, width: 200, height: 300))
        testLabel.backgroundColor = .brown
        testLabel.numberOfLines = 0
        testLabel.font = UIFont.systemFont(ofSize: 15)
        testLabel.text("梅花以它弱小娇艳的身躯，凌寒傲雪，傲然绽放，装点着寂寞荒凉的冬日")
        self.view.addSubview(testLabel)
        JXAsyncs.asyncDelay(2, {
        }) {
            testLabel.jx.setsetSpecificTextFont("的", font: UIFont.systemFont(ofSize: 30))
            JXAsyncs.asyncDelay(3, {
            }) {
                testLabel.removeFromSuperview()
            }
        }
    }
    
    // MARK: 3.1、设置特定区域的字体大小
    @objc func test31() {
        let testLabel = UILabel(frame: CGRect(x: 50, y: 100, width: 200, height: 300))
        testLabel.backgroundColor = .brown
        testLabel.numberOfLines = 0
        testLabel.font = UIFont.systemFont(ofSize: 15)
        testLabel.text("梅花以它弱小娇艳的身躯，凌寒傲雪，傲然绽放，装点着寂寞荒凉的冬日")
        self.view.addSubview(testLabel)
        JXAsyncs.asyncDelay(2, {
        }) {
            testLabel.jx.setRangeFontText(font: UIFont.systemFont(ofSize: 30), range: NSRange(location: 2, length: 5))
            JXAsyncs.asyncDelay(3, {
            }) {
                testLabel.removeFromSuperview()
            }
        }
    }
}


// MARK: - 二、其他的基本扩展
extension UILabelExtensionViewController {
    
    // MARK: 2.1、获取已知 frame 的 label 的文本行数 & 每一行内容
    @objc func test21() {
        let testLabel = UILabel(frame: CGRect(x: 50, y: 100, width: 200, height: 300))
        testLabel.backgroundColor = .brown
        testLabel.numberOfLines = 0
        testLabel.text("梅花以它弱小娇艳的身躯，凌寒傲雪，傲然绽放，装点着寂寞荒凉的冬日。这是怎样的一种坚信和执着啊?因为它知道，不经历寒风冬雪的浸染，怎能有朵朵红花的暗香浮动?因为它知道，冬天过去了，春天还会遥远吗?")
        self.view.addSubview(testLabel)
        let result = testLabel.jx.linesCountAndLinesContent(lineSpace: 2)
        if let number = result.0 {
            print("行数：\(number)")
        }
        if let contents = result.1 {
            print("内容：\(contents)")
        }
        JXAsyncs.asyncDelay(3, {
        }) {
            testLabel.removeFromSuperview()
        }
    }
    
    // MARK: 2.2、获取已知 width 的 label 的文本行数 & 每一行内容
    @objc func test22() {
        let testLabel = UILabel(frame: CGRect(x: 50, y: 100, width: 200, height: 300))
        testLabel.backgroundColor = .brown
        testLabel.numberOfLines = 0
        testLabel.text("梅花以它弱小娇艳的身躯，凌寒傲雪，傲然绽放，装点着寂寞荒凉的冬日。这是怎样的一种坚信和执着啊?因为它知道，不经历寒风冬雪的浸染，怎能有朵朵红花的暗香浮动?因为它知道，冬天过去了，春天还会遥远吗?")
        self.view.addSubview(testLabel)
        let result = testLabel.jx.accordWidthLinesCountAndLinesContent(accordWidth: 200, lineSpace: 2)
        if let number = result.0 {
            print("行数：\(number)")
        }
        if let contents = result.1 {
            print("内容：\(contents)")
        }
        JXAsyncs.asyncDelay(3, {
        }) {
            testLabel.removeFromSuperview()
        }
    }
    
    // MARK: 2.3、获取第一行内容
    @objc func test23() {
        let testLabel = UILabel(frame: CGRect(x: 50, y: 100, width: 200, height: 300))
        testLabel.backgroundColor = .brown
        testLabel.font(19)
        testLabel.numberOfLines = 0
        testLabel.text("梅花以它弱小娇艳的身躯，凌寒傲雪，傲然绽放，装点着寂寞荒凉的冬日。这是怎样的一种坚信和执着啊?因为它知道，不经历寒风冬雪的浸染，怎能有朵朵红花的暗香浮动?因为它知道，冬天过去了，春天还会遥远吗?")
        self.view.addSubview(testLabel)
        if let firstLine = testLabel.jx.firstLineString {
            print("获取第一行内容", "\(firstLine)")
        }
        JXAsyncs.asyncDelay(3, {
        }) {
            testLabel.removeFromSuperview()
        }
    }
    
    // MARK: 2.4、改变行间距
    @objc func test24() {
        let testLabel = UILabel(frame: CGRect(x: 50, y: 100, width: 200, height: 300))
        testLabel.backgroundColor = .brown
        testLabel.font(19)
        testLabel.numberOfLines = 0
        testLabel.text("梅花以它弱小娇艳的身躯，凌寒傲雪，傲然绽放，装点着寂寞荒凉的冬日。这是怎样的一种坚信和执着啊?因为它知道，不经历寒风冬雪的浸染，怎能有朵朵红花的暗香浮动?因为它知道，冬天过去了，春天还会遥远吗?")
        self.view.addSubview(testLabel)
        JXAsyncs.asyncDelay(3, {
        }) {
            testLabel.jx.changeLineSpace(space: 10)
            JXAsyncs.asyncDelay(3, {
            }) {
                testLabel.removeFromSuperview()
            }
        }
    }
    
    // MARK: 2.5、改变字间距
    @objc func test25() {
        
        let testLabel = UILabel(frame: CGRect(x: 50, y: 100, width: 200, height: 300))
        testLabel.backgroundColor = .brown
        testLabel.font(19)
        testLabel.numberOfLines = 0
        testLabel.text("梅花以它弱小娇艳的身躯，凌寒傲雪，傲然绽放，装点着寂寞荒凉的冬日。这是怎样的一种坚信和执着啊?因为它知道，不经历寒风冬雪的浸染，怎能有朵朵红花的暗香浮动?因为它知道，冬天过去了，春天还会遥远吗?")
        self.view.addSubview(testLabel)
        JXAsyncs.asyncDelay(3, {
        }) {
            testLabel.jx.changeWordSpace(space: 4)
            JXAsyncs.asyncDelay(3, {
            }) {
                testLabel.removeFromSuperview()
            }
        }
    }
    
    // MARK: 2.6、改变字间距和行间距
    @objc func test26() {
        let testLabel = UILabel(frame: CGRect(x: 50, y: 100, width: 200, height: 300))
        testLabel.backgroundColor = .brown
        testLabel.font(19)
        testLabel.numberOfLines = 0
        testLabel.text("梅花以它弱小娇艳的身躯，凌寒傲雪，傲然绽放，装点着寂寞荒凉的冬日。这是怎样的一种坚信和执着啊?因为它知道，不经历寒风冬雪的浸染，怎能有朵朵红花的暗香浮动?因为它知道，冬天过去了，春天还会遥远吗?")
        self.view.addSubview(testLabel)
        JXAsyncs.asyncDelay(3, {
        }) {
            testLabel.jx.changeSpace(lineSpace: 4, wordSpace: 4)
            JXAsyncs.asyncDelay(3, {
            }) {
                testLabel.removeFromSuperview()
            }
        }
    }
    
    // MARK: 2.7、label添加中划线
    @objc func test27() {
        let testLabel = UILabel(frame: CGRect(x: 50, y: 100, width: 200, height: 300))
        testLabel.backgroundColor = .brown
        testLabel.font(19)
        testLabel.numberOfLines = 0
        testLabel.text("梅花以它弱小娇艳的身躯，凌寒傲雪，傲然绽放，装点着寂寞荒凉的冬日。这是怎样的一种坚信和执着啊?因为它知道，不经历寒风冬雪的浸染，怎能有朵朵红花的暗香浮动?因为它知道，冬天过去了，春天还会遥远吗?")
        testLabel.jx.centerLineText(lineValue: 1, underlineColor: .red)
        self.view.addSubview(testLabel)
        
        JXAsyncs.asyncDelay(3, {
        }) {
            testLabel.removeFromSuperview()
        }
    }
}

// MARK: - 一、链式编程
extension UILabelExtensionViewController {
    
    // MARK: 1.1、设置文字
    @objc func test11() {
        let testLabel = UILabel(frame: CGRect(x: 50, y: 100, width: 200, height: 100))
        testLabel.backgroundColor = .brown
        testLabel.text("2秒后消失")
        testLabel.tintColor = .yellow
        self.view.addSubview(testLabel)
        JXAsyncs.asyncDelay(2, {
        }) {
            testLabel.removeFromSuperview()
        }
    }
    
    // MARK: 1.2、设置文字行数
    @objc func test12() {
        let testLabel = UILabel(frame: CGRect(x: 50, y: 100, width: 200, height: 200))
        testLabel.backgroundColor = .brown
        testLabel.text("梅花以它弱小娇艳的身躯，凌寒傲雪，傲然绽放，装点着寂寞荒凉的冬日。这是怎样的一种坚信和执着啊?因为它知道，不经历寒风冬雪的浸染，怎能有朵朵红花的暗香浮动?因为它知道，冬天过去了，春天还会遥远吗?")
        testLabel.line(0)
        testLabel.tintColor = .yellow
        self.view.addSubview(testLabel)
        JXAsyncs.asyncDelay(2, {
        }) {
            testLabel.removeFromSuperview()
        }
    }
    
    // MARK: 1.3、设置文字对齐方式
    @objc func test13() {
        let testLabel = UILabel(frame: CGRect(x: 50, y: 100, width: 200, height: 100))
        testLabel.backgroundColor = .brown
        testLabel.text("2秒后消失")
        testLabel.textAlignment(.right)
        testLabel.tintColor = .yellow
        self.view.addSubview(testLabel)
        JXAsyncs.asyncDelay(2, {
        }) {
            testLabel.removeFromSuperview()
        }
    }
    
    // MARK: 1.4、设置富文本文字
    @objc func test14() {
        let attributedString = NSMutableAttributedString(string: "我是一只小小鸟").color(.randomColor).font(22)
        let testLabel = UILabel(frame: CGRect(x: 50, y: 100, width: 200, height: 100))
        testLabel.backgroundColor = .brown
        testLabel.attributedText(attributedString)
        testLabel.textAlignment(.right)
        testLabel.tintColor = .yellow
        self.view.addSubview(testLabel)
        JXAsyncs.asyncDelay(2, {
        }) {
            testLabel.removeFromSuperview()
        }
    }
    
    // MARK: 1.5、设置文本颜色
    @objc func test15() {
        let testLabel = UILabel(frame: CGRect(x: 50, y: 100, width: 200, height: 100)).text("2秒后消失").color(.yellow)
        testLabel.backgroundColor = .brown
        testLabel.textAlignment(.right)
        self.view.addSubview(testLabel)
        JXAsyncs.asyncDelay(2, {
        }) {
            testLabel.removeFromSuperview()
        }
    }
    
    // MARK: 1.6、设置文本颜色（十六进制字符串）
    @objc func test16() {
        let testLabel = UILabel(frame: CGRect(x: 50, y: 100, width: 200, height: 100)).text("2秒后消失").color("#32CD32")
        testLabel.backgroundColor = .brown
        testLabel.textAlignment(.right)
        self.view.addSubview(testLabel)
        JXAsyncs.asyncDelay(2, {
        }) {
            testLabel.removeFromSuperview()
        }
    }
    
    // MARK: 1.7、设置字体的大小
    @objc func test17() {
        let testLabel = UILabel(frame: CGRect(x: 50, y: 100, width: 200, height: 100)).text("2秒后消失").color("#32CD32").font(UIFont.systemFont(ofSize: 16))
        testLabel.backgroundColor = .brown
        testLabel.textAlignment(.right)
        self.view.addSubview(testLabel)
        JXAsyncs.asyncDelay(2, {
        }) {
            testLabel.removeFromSuperview()
        }
    }
    
    // MARK: 1.8、设置字体的大小
    @objc func test18() {
        let testLabel = UILabel(frame: CGRect(x: 50, y: 100, width: 200, height: 100)).text("2秒后消失").color("#32CD32").font(12)
        testLabel.backgroundColor = .brown
        testLabel.textAlignment(.right)
        self.view.addSubview(testLabel)
        JXAsyncs.asyncDelay(2, {
        }) {
            testLabel.removeFromSuperview()
        }
    }
    
    // MARK: 1.9、设置字体的大小（粗体）
    @objc func test19() {
        let testLabel = UILabel(frame: CGRect(x: 50, y: 100, width: 200, height: 100)).text("2秒后消失").color("#32CD32").boldFont(18)
        testLabel.backgroundColor = .brown
        testLabel.textAlignment(.right)
        self.view.addSubview(testLabel)
        JXAsyncs.asyncDelay(2, {
        }) {
            testLabel.removeFromSuperview()
        }
    }
}

