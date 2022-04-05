//
//  UIFontExtensionViewController.swift
//  SwiftLession01
//
//  Created by wjx on 2022/3/30.
//

import UIKit

class UIFontExtensionViewController: TestBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
              headDataArray = ["一、常用的基本字体扩展", "二、自定义字体"]
              dataArray = [["系统字体", "常规字体", "中等的字体", "加粗的字体", "半粗体的字体", "超细的字体", "纤细的字体", "亮字体", "介于Bold和Black之间", "最粗字体", "测试"], ["常规字体", "中等的字体", "加粗的字体", "半粗体的字体"]]
        
        // Do any additional setup after loading the view.
    }

}
// MARK: - 二、自定义字体
extension UIFontExtensionViewController {
    // MARK: 2.4、半粗体的字体
    @objc func test24() {
        var label = UILabel(frame: CGRect(x: 0, y: 100, width: UIScreen.jx.width - 60, height: 50))
        label.backgroundColor = .green
        label.textColor = .brown
        label.text = "我是一只小小鸟"
        label.font = UIFont.jx.customFontSB(16)
        label.jx.centerX = self.view.jx.centerX
        label.textAlignment = .center
        self.view.addSubview(label)
        
        JXAsyncs.asyncDelay(1, {
        }) {
            label.font = UIFont.jx.customFontSB(26)
            JXAsyncs.asyncDelay(1, {
            }) {
                label.removeFromSuperview()
            }
        }
    }
    
    // MARK: 2.3、加粗的字体
    @objc func test23() {
        var label = UILabel(frame: CGRect(x: 0, y: 100, width: UIScreen.jx.width - 60, height: 50))
        label.backgroundColor = .green
        label.textColor = .brown
        label.text = "我是一只小小鸟"
        label.font = UIFont.jx.customFontB(16)
        label.jx.centerX = self.view.jx.centerX
        label.textAlignment = .center
        self.view.addSubview(label)
        
        JXAsyncs.asyncDelay(1, {
        }) {
            label.font = UIFont.jx.customFontB(26)
            JXAsyncs.asyncDelay(1, {
            }) {
                label.removeFromSuperview()
            }
        }
    }
    
    // MARK: 2.2、中等的字体
    @objc func test22() {
        var label = UILabel(frame: CGRect(x: 0, y: 100, width: UIScreen.jx.width - 60, height: 50))
        label.backgroundColor = .green
        label.textColor = .brown
        label.text = "我是一只小小鸟"
        label.font = UIFont.jx.customFontM(16)
        label.jx.centerX = self.view.jx.centerX
        label.textAlignment = .center
        self.view.addSubview(label)
        
        JXAsyncs.asyncDelay(1, {
        }) {
            label.font = UIFont.jx.customFontM(26)
            JXAsyncs.asyncDelay(1, {
            }) {
                label.removeFromSuperview()
            }
        }
    }
    
    // MARK: 2.1、常规字体
    @objc func test21() {
        var label = UILabel(frame: CGRect(x: 0, y: 100, width: UIScreen.jx.width - 60, height: 50))
        label.backgroundColor = .green
        label.textColor = .brown
        label.text = "我是一只小小鸟"
        label.font = UIFont.jx.customFontR(16)
        label.jx.centerX = self.view.jx.centerX
        label.textAlignment = .center
        self.view.addSubview(label)
        
        JXAsyncs.asyncDelay(1, {
        }) {
            label.font = UIFont.jx.customFontR(26)
            JXAsyncs.asyncDelay(1, {
            }) {
                label.removeFromSuperview()
            }
        }
    }
}
