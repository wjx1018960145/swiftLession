//
//  CAGradientLayerExtensionViewController.swift
//  SwiftLession01
//
//  Created by wjx on 2022/4/29.
//

import UIKit

class CAGradientLayerExtensionViewController: TestBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        headDataArray = ["一、基本的颜色扩展"]
        dataArray = [["背景的渐变设置"]]
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
// MARK: - 一、基本的颜色扩展
extension CAGradientLayerExtensionViewController {
    
    // MARK: 1.1、背景的渐变设置
    @objc func test11() {
        // 获取彩虹渐变层
        let gradientLayer = CAGradientLayer().jx.gradientLayer(.horizontal, [UIColor.red.cgColor, UIColor.green.cgColor], nil)
        
        let button = UIButton(frame: CGRect(x: 30, y: 150, width: jx_kScreenW - 60, height: 50))
        self.view.addSubview(button)
        
        // 设置其CAGradientLayer对象的frame，并插入button的layer
        gradientLayer.frame = CGRect(x: 0, y: 0, width: button.jx.width, height: button.jx.height)
        button.layer.insertSublayer(gradientLayer, at: 0)
        
        JXAsyncs.asyncDelay(2) {
        } _: {
            button.removeFromSuperview()
        }
    }
}
