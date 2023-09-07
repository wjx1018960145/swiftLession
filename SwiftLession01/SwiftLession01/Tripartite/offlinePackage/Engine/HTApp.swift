//
//  HTApp.swift
//  SwiftLession01
//
//  Created by wjx on 2022/6/27.
//

import Foundation
import SwiftUI
// 下载时机,枚举值与服务端返回值对应
enum HTDownType : Int {
    case HTDownTypeWifi = 0
    case HTDownTypeAny = 1
    case HTDownTypeUse = 2
}

// 安装类型,枚举值与服务端返回值对应
enum HTInstallType :Int {
   case HTInstallTypeUse = 0
   case HTInstallTypeAny = 1
}

// 应用类型
enum HTAppType :Int{
   case HTAppTypeH5 = 1   // H5
   case HTAppTypeRN = 5    // RN
}

// 应用来源
enum HTAppChannel :Int {
   case HTAppChannelAlipay = 1       // 支付宝自建应用
    case HTAppChannelAlibaba = 2           // 集团应用
    case HTAppChannelThirdParty = 3        // 第三方
    case HTAppChannelApplet     = 4        // 小程序
}

public class HTApp :NSObject ,NSCopying {
    
   static var nbl_id:String?             // 应用唯一标识, e.g. AP_20000001
    static var app_id:String?             // 应用id, e.g. 20000001
    static var name:String?               // 应用名称, e.g. 机票
    static var version:String?            // 应用版本, e.g. 1.0.0.0
    static var desc:String?             // 应用描述 (钱包内请勿使用该参数)
    static var package_url:String?       // 应用离线包下载url
    static  var icon_url:String?
    static var main_url:String?          //主入口url
    
    /**
     *  根据字典初始化对象
     *
     *  @return 字典格式非法、无appid、无version情况下返回nil
     */
    func initWithDict(dictionary:Dictionary<String, Any>){
        if dictionary["app_id"] == nil || dictionary["version"] == nil {
            print("初始化失败缺少APPID，或者版本号")
            return
        }
        HTApp.nbl_id = dictionary["nbl_id"] as? String
        HTApp.app_id = dictionary["app_id"] as? String
        HTApp.name = dictionary  ["name"]  as? String
        HTApp.version = dictionary["version"] as? String
        HTApp.desc   = dictionary["desc"] as? String
        HTApp.package_url = (dictionary["package_url"] as? String)!
        HTApp.icon_url = dictionary["iconUrl"] as? String
        HTApp.main_url = dictionary["main_url"] as? String
        
    }
    
    
    
    
    
    public func copy(with zone: NSZone? = nil) -> Any {
        
        return ""
    }
    
    
}
