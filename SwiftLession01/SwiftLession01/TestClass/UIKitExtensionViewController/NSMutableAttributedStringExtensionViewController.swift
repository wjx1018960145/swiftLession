//
//  NSMutableAttributedStringExtensionViewController.swift
//  SwiftLession01
//
//  Created by wjx on 2022/5/12.
//

import UIKit

class NSMutableAttributedStringExtensionViewController: TestBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        headDataArray = ["一、基本的链式编程"]
        dataArray = [["设置 删除线", "设置富文本文字的颜色", "设置富文本文字的颜色(十六进制字符串颜色)", "设置富文本文字的大小", "设置富文本文字的 UIFont"]]
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
// MARK: - 一、基本的链式编程
extension NSMutableAttributedStringExtensionViewController {
    
    // MARK: 1.1、设置 删除线
    @objc func test11() {
        let attributedString = NSMutableAttributedString(string: "2秒后消失").strikethrough()
        let testView1 = UILabel(frame: CGRect(x: 200, y: 100, width: 100, height: 100))
        testView1.backgroundColor = .brown
        testView1.attributedText = attributedString
        testView1.addTo(self.view)
        JXAsyncs.asyncDelay(2, {
        }) {
            testView1.removeFromSuperview()
        }
    }
    
    // MARK: 1.2、设置富文本文字的颜色
    @objc func test12() {
        let attributedString = NSMutableAttributedString(string: "2秒后消失").color(.green)
        let testView1 = UILabel(frame: CGRect(x: 200, y: 100, width: 100, height: 100))
        testView1.backgroundColor = .brown
        testView1.attributedText = attributedString
        testView1.addTo(self.view)
        JXAsyncs.asyncDelay(2, {
        }) {
            testView1.removeFromSuperview()
        }
    }
    
    // MARK: 1.3、设置富文本文字的颜色(十六进制字符串颜色)
    @objc func test13() {
        let attributedString = NSMutableAttributedString(string: "2秒后消失").color("#FFA500")
        let testView1 = UILabel(frame: CGRect(x: 200, y: 100, width: 100, height: 100))
        testView1.backgroundColor = .brown
        testView1.attributedText = attributedString
        testView1.addTo(self.view)
        JXAsyncs.asyncDelay(2, {
        }) {
            testView1.removeFromSuperview()
        }
    }
    
    // MARK: 1.4、设置富文本文字的大小
    @objc func test14() {
        let attributedString = NSMutableAttributedString(string: "2秒后消失").color(.green).font(30)
        let testView1 = UILabel(frame: CGRect(x: 50, y: 100, width: jx_kScreenW - 100, height: 100))
        testView1.backgroundColor = .brown
        testView1.attributedText = attributedString
        testView1.addTo(self.view)
        JXAsyncs.asyncDelay(2, {
        }) {
            testView1.removeFromSuperview()
        }
    }
    
    // MARK: 1.5、设置富文本文字的 UIFont
    @objc func test15() {
        let attributedString = NSMutableAttributedString(string: "2秒后消失").color(.green).font(UIFont.systemFont(ofSize: 11))
        let testView1 = UILabel(frame: CGRect(x: 50, y: 100, width: jx_kScreenW - 100, height: 100))
        testView1.backgroundColor = .brown
        testView1.attributedText = attributedString
        testView1.addTo(self.view)
        JXAsyncs.asyncDelay(2, {
        }) {
            testView1.removeFromSuperview()
        }
    }
}
