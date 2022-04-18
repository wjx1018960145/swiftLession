//
//  DictionaryExtensionViewController.swift
//  SwiftLession01
//
//  Created by wjx on 2022/4/18.
//

import UIKit

class DictionaryExtensionViewController: TestBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        headDataArray = ["一、基本的扩展", "二、其他基本扩展"]
        dataArray = [["检查字典里面是否有某个 key", "字典的key或者value组成的数组", "JSON字符串 -> 字典", "字典 -> JSON字符串", "字典里面所有的 key", "字典里面所有的 value", "设置value1", "设置value2"], ["字典转JSON"]]
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
// MARK: - 二、其他基本扩展
extension DictionaryExtensionViewController {
    
    // MARK: 2.1、字典转JSON
    @objc func test21() {
        let dictionary: Dictionary<String, Any> = ["b": "2", "a": "1"]
        print("字典转JSON", "字典：\(dictionary) 转JSON为：\(dictionary.jx.dictionaryToJson() ?? "无法解析")")
    }
}

// MARK: - 一、基本的扩展
extension DictionaryExtensionViewController {
    
    // MARK: 1.8、设置value
    @objc func test18() {
        var japan: [String: Any] = [
            "name": "Japan",
            "capital": "Tokyo",
            "population": 126_740_000,
            "coordinates": [
                "latitude": 35.0,
                "longitude": 139.0,
                "names": [
                    "A": "a",
                    "B": "b"
                ]
            ]
        ]
        // 优化后
        japan.setValue(keys: ["capital"], newValue: "我是修改过的：capital")
        japan.setValue(keys: ["coordinates", "latitude"], newValue: "我是修改过的：latitude")
        japan.setValue(keys: ["coordinates", "names", "A"], newValue: "我是修改过的A")
        print(japan)
    }
    
    // MARK: 1.7、设置value
    @objc func test17() {
        var japan: [String: Any] = [
            "name": "Japan",
            "capital": "Tokyo",
            "population": 126_740_000,
            "coordinates": [
                "latitude": 35.0,
                "longitude": 139.0,
                "names": [
                    "A": "a",
                    "B": "b"
                ]
            ]
        ]
        // 优化后
        japan["coordinates", as: [String: Any].self]?["names", as: [String: Any].self]?["A"] = "我是修改过的A"
        print(japan)
    }
    
    // MARK: 1.6、字典里面所有的 values
    @objc func test16() {
        let dictionary = ["b": "2", "a": "1"]
        print("字典里面所有的 values", "字典：\(dictionary) 的所有values为：\(dictionary.allValues())")
    }
    
    // MARK: 1.5、字典里面所有的 key
    @objc func test15() {
        let dictionary = ["b": "2", "a": "1"]
        print("字典里面所有的 keys", "字典：\(dictionary) 的所有keys为：\(dictionary.allKeys())")
    }
    
    // MARK: 1.4、字典 -> JSON字符串
    @objc func test14() {
        let dictionary = ["a": "1", "b": "2"]
        guard let json = dictionary.toJSON() else {
            return
        }
        print("字典 -> JSON字符串", "字典：\(dictionary) 转JSON字符串后为：\(json)")
    }
    
    // MARK: 1.3、JSON字符串 -> 字典
    @objc func test13() {
        let dictionary = ["a": "1", "b": "2"]
        guard let json = dictionary.toJSON(), let newDictionary = json.jx.jsonStringToDictionary() else {
            return
        }
        print("JSON字符串 -> 字典", "JSON字符串：\(json) 转为字典为：\(newDictionary)")
    }
    
    // MARK: 1.2、字典的key或者value组成的数组
    @objc func test12() {
        let dictionary = ["a": "1", "b": "2"]
        let array = dictionary.toArray { (key, value) -> String in
            return key
        }
        print("字典的key或者value组成的数组", "字典 \(dictionary) 的key组成的数组是：\(array)")
    }
    
    // MARK: 1.1、检查字典里面是否有某个 key
    @objc func test11() {
        let dictionary = ["a": "1", "b": "2"]
        let key = "c"
        print("检查字典里面是否有某个 key", "检查字典\(dictionary) 里面有没有键：\(key) ，结果是：\(dictionary.has(key))")
    }
}
