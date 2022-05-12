//
//  UISliderExtensionViewController.swift
//  SwiftLession01
//
//  Created by wjx on 2022/5/12.
//

import UIKit

class UISliderExtensionViewController: TestBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        headDataArray = ["一、基本的扩展"]
        dataArray = [["UISlider的 闭包事件"]]
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
extension UISliderExtensionViewController {
    
    // MARK: 1.1、UISlider的 闭包事件
    @objc func test11() {
        let slider = UISlider(frame: CGRect(x: 50, y: 100, width: 150, height: 50))
        slider.backgroundColor = .randomColor
        slider.maximumValue = 1
        slider.minimumValue = 0
        slider.value = 0.2
        slider.jx.setHandle { (value) in
            guard let weakvalue = value else {
                return
            }
            print("\(weakvalue)")
        }
        self.view.addSubview(slider)
        
        JXAsyncs.asyncDelay(20) {
        } _: {
            slider.removeFromSuperview()
        }

    }
}
