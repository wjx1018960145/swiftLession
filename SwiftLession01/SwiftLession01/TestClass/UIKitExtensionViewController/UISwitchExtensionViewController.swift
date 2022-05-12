//
//  UISwitchExtensionViewController.swift
//  SwiftLession01
//
//  Created by wjx on 2022/5/12.
//

import UIKit

class UISwitchExtensionViewController: TestBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        headDataArray = ["一、基本的扩展"]
        dataArray = [["开关切换", "开关事件"]]
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

// MARK: - 一、一、基本的扩展
extension UISwitchExtensionViewController {
    
    // MARK: 1.2、开关事件
    @objc func test12() {
        let sh = UISwitch(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        sh.backgroundColor = .brown
        sh.jx.setHandle { (result) in
            guard let weakResult = result else { return }
            print("开关的状态", "\(weakResult)")
        }
        sh.addTo(self.view)
        
        JXAsyncs.asyncDelay(10, {
        }) {
            sh.removeFromSuperview()
        }
    }
    
    // MARK: 1.1、开关切换
    @objc func test11() {
        let sh = UISwitch(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        sh.backgroundColor = .brown
        sh.addTo(self.view)
        
        JXAsyncs.asyncDelay(2, {
        }) {
            sh.jx.toggle()
            JXAsyncs.asyncDelay(5, {
            }) {
                sh.removeFromSuperview()
            }
        }
        
    }
    
}
