//
//  DataExtensionViewController.swift
//  SwiftLession01
//
//  Created by wjx on 2022/4/15.
//

import UIKit

class DataExtensionViewController: TestBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        headDataArray = ["一、基本的扩展"]
        dataArray = [["base64编码成 Data", "base64解码成 Data", "转成bytes"]]
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
extension DataExtensionViewController {
    
    // MARK: 1.3、转成bytes
    @objc func test13() {
        let content = "我是一只小小鸟"
        guard let data = content.data(using: String.Encoding.utf8), let resultData = data.jx.encodeToData  else {
            return
        }
        print("转成bytes：\(resultData.jx.bytes)")
    }
    
    // MARK: 1.2、base64解码成 Data
    @objc func test12() {
        let content = "我是一只小小鸟"
        guard let data = content.data(using: String.Encoding.utf8), let resultData = data.jx.encodeToData  else {
            return
        }
        guard let oldData = resultData.jx.decodeToDada, let oldString = String(data: oldData, encoding: .utf8) else {
            return
        }
        print("base64编码成 Data：\(resultData)", "解码后的data是：\(oldData)", "解码后的 String：\(oldString)")
    }
    
    // MARK: 1.1、base64编码成 Data
    @objc func test11() {
        let content = "我是一只小小鸟"
        guard let data = content.data(using: String.Encoding.utf8), let resultData = data.jx.encodeToData else {
            return
        }
        print("\(content ) 被 base64编码成 Data：\(resultData)")
    }
}
