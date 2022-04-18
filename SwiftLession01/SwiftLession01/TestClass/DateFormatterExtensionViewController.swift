//
//  DateFormatterExtensionViewController.swift
//  SwiftLession01
//
//  Created by wjx on 2022/4/6.
//

import UIKit

class DateFormatterExtensionViewController: TestBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        headDataArray = ["一、基本的扩展"]
        dataArray = [["格式化快捷方式"]]
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
extension DateFormatterExtensionViewController {
    
    // MARK: 1.1、格式化快捷方式
    @objc func test11() {
        let dateFormatter = DateFormatter(format: "EEEE")
        print("格式化快捷方式", "\(dateFormatter)")
    }
}

