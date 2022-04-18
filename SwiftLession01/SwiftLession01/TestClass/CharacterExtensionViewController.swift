//
//  CharacterExtensionViewController.swift
//  SwiftLession01
//
//  Created by wjx on 2022/4/18.
//

import UIKit

class CharacterExtensionViewController: TestBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        headDataArray = ["一、Character 与其他类型的转换", "二、常用的属性和方法"]
        dataArray = [["Character 转 String", "Character 转 Int"], ["判断是不是 Emoji 表情"]]
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
// MARK: - 二、常用的属性和方法
extension CharacterExtensionViewController {
    
    // MARK: 2.1、判断是不是 Emoji 表情
    @objc func test21() {
        let emoji: Character = "🙃"
        print("判断是不是 Emoji 表情", "\(emoji) 是不是emoji表情：\(emoji.jx.isEmoji)")
    }
}

// MARK: - 一、Character 与其他类型的转换
extension CharacterExtensionViewController {
    
    // MARK: 1.1、Character 转 String
    @objc func test11() {
        let charater: Character = "a"
        print("Character 转 String", "\(charater) 转 String 后为 \(charater.jx.charToString)")
    }
    
    // MARK: 1.2、Character 转 Int
    @objc func test12() {
        let charater: Character = "f"
        print("Character 转 Int", "\(charater) 转 Int 后为 \(charater.jx.charToInt ?? 0)")
    }
}

