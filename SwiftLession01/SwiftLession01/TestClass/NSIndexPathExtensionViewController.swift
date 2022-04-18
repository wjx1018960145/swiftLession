//
//  NSIndexPathExtensionViewController.swift
//  SwiftLession01
//
//  Created by wjx on 2022/4/15.
//

import UIKit

class NSIndexPathExtensionViewController: TestBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        headDataArray = ["一、基本扩展"]
        dataArray = [["{section, row}", "当前 NSIndexPath 的前一个 NSIndexPath", "当前 NSIndexPath 的后一个 NSIndexPath"]]
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
// MARK: - 一、基本扩展
extension NSIndexPathExtensionViewController {
   
    // MARK: 1.3、当前 NSIndexPath 的后一个 NSIndexPath
    @objc func test13() {
        
    }
    
    // MARK: 1.2、当前 NSIndexPath 的前一个 NSIndexPath
    @objc func test12() {
        
    }
    
    // MARK: 1.1、{section, row}
    @objc func test11() {
        
    }
}
