//
//  UserDefaultsExtensionViewController.swift
//  SwiftLession01
//
//  Created by wjx on 2022/4/15.
//

import UIKit
struct PersonItem: Codable {
    var name: String?
    var age: String?
    var height: String?
    
    //区别 可以将字典中`Name`的值解析到`name`
    fileprivate enum CodingKeys: String, CodingKey {
        case name = "Name"
        case age
        case height
    }
}

class UserDefaultsExtensionViewController: TestBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        headDataArray = ["一、基本的扩展", "二、模型持久化（复杂类型）"]
        dataArray = [["存值", "取值", "移除单个值", "移除所有值"], ["存储模型", "取出模型"]]
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
// MARK: - 二、模型持久化（复杂类型）
extension UserDefaultsExtensionViewController {
    
    // MARK: 2.2、取出模型
    @objc func test22() {
        
        guard let person =  UserDefaults.jx.getItem(PersonItem.self, forKey: "plistData") else {
            return
        }
        print("有内容：", "名字：\(person.name ?? "")", "年龄：\(person.age ?? "")", "身高：\(person.height ?? "")")
        
    }
    
    // MARK: 2.1、存储模型
    @objc func test21() {
        let  filePath: String? = Bundle.main.path(forResource: "", ofType: "plist")
        guard let plistData = NSDictionary(contentsOfFile: filePath ?? "") else {
            return
        }
         
        let person = PersonItem(name: (plistData["Name"] as! String), age: (plistData["age"] as! String), height: (plistData["height"] as! String))
        UserDefaults.jx.setItem(person, forKey: "plistData")
    }
}
// MARK: - 一、基本的扩展
extension UserDefaultsExtensionViewController {
    
    // MARK: 1.4、移除所有值
    @objc func test14() {
        UserDefaults.jx.removeAllKeyValue()
    }
    
    // MARK: 1.3、移除单个值
    @objc func test13() {
        UserDefaults.jx.remove("a")
    }
    
    // MARK: 1.2、取值
    @objc func test12() {
        guard let value = UserDefaults.jx.userDefaultsGetValue(key: "a") else {
            return
        }
        print("存值成功：\(value)")
    }
    
    // MARK: 1.1、存值
    @objc func test11() {
        let isSuccess = UserDefaults.jx.userDefaultsSetValue(value: "我是小可爱", key: "a")
        if isSuccess {
            print("存值成功")
        } else {
            print("存值失败")
        }
    }
}
