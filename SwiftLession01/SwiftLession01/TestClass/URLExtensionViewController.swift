//
//  URLExtensionViewController.swift
//  SwiftLession01
//
//  Created by wjx on 2022/4/18.
//

import UIKit

class URLExtensionViewController: TestBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        headDataArray = ["一、基本的扩展"]
        dataArray = [["提取链接中的参数以字典像是显示", "属性说明", "检测应用是否能打开这个URL实例"]]
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
extension URLExtensionViewController {
    
    // MARK: 1.3、检测应用是否能打开这个URL实例
    @objc func test13() {
        guard let url = URL(string: "https://www.baidu.com") else {
            return
        }
        let result = url.jx.verifyUrl()
        print("检测应用是否能打开这个URL实例：\(result)")
    }
    
    // MARK: 1.2、属性说明
    @objc func test12() {
        
        guard let url = URL(string: "huacai://com.huacai.stock/hah/?type=1&id=2") else {
            return
        }
        url.jx.propertyDescription()
    }
    
    // MARK: 1.1、提取链接中的参数以字典像是显示
    @objc func test11() {
        
        guard let url = URL(string: "huacai://com.huacai.stock/hah/?type=1&id=2&info={name: 你好}"), let query = url.jx.queryParameters else {
            return
        }
        print("内容", "\(url) 取后为 \(query)")
    }
}
