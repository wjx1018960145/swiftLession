//
//  Utils.swift
//  SwiftLession01
//
//  Created by wjx on 2021/12/14.
//

import UIKit
import Foundation
import MBProgressHUD

class Utils: NSObject {

    // 从Bundle中读取并解析JSON文件生成Model
    func loadBundleJSONFile(_ filename: String) -> Data {
        let data: Data
        guard let file = Bundle.main.url(forResource: filename, withExtension: nil) else {
            fatalError("Couldn't find \(filename) in main bundle.")
        }
        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
        }
       return data
    }

    // 读取指定路径下文件内容
    func loadFileContent(path: String) -> String {
        do {
            return try String(contentsOfFile: path, encoding: String.Encoding.utf8)
        } catch {
            return ""
        }
    }
    
    func getlockSourceForArr(fileName:String)->NSArray{
        
        let dicArr  = try! JSONSerialization.jsonObject(with: loadBundleJSONFile(fileName), options: .allowFragments) as! [[String:AnyObject]]
        return dicArr as NSArray
    }
    
    func getlockSourceForDic(fileName:String)->NSDictionary{
        
        let dicDic  = try! JSONSerialization.jsonObject(with: loadBundleJSONFile(fileName), options: .allowFragments) as! [String:AnyObject]
        return dicDic as NSDictionary
    }

}




extension UIViewController {

    func showHUD(_ text: String) -> MBProgressHUD {
        let HUD = MBProgressHUD.showAdded(to: view, animated: true)
        HUD.label.text = text
        HUD.removeFromSuperViewOnHide = true
        return HUD
    }
    
}
