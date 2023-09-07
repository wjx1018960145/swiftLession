//
//  HTWebAppearance.swift
//  SwiftLession01
//
//  Created by wjx on 2022/6/28.
//

import UIKit

class HTWebAppearance: NSObject {

   static let  sharedAppearance = HTWebAppearance()
    
    // 导航栏返回按钮的图片
    let backItemImage:UIImage?
    // 关闭按钮的图片
    let closeItemImage:UIImage?
    // 网页访问进度条颜色
    let progressColor:UIColor?
    // 网页 MenuItem 的图标
//    let menuItemImage:UIImage?
    //右侧返回根目录图标
    let rootCloseItemImage:UIImage?
    
    override init(){
        self.backItemImage = UIImage.init(contentsOfFile: Bundle.jx.getBundlePathResource(bundName: "JSWebKit", resourceName: "webKitNaviBack"))
        self.progressColor = .gray
        self.closeItemImage = UIImage.init(contentsOfFile: Bundle.jx.getBundlePathResource(bundName: "JSWebKit", resourceName: "webKitClose"))
//        self.menuItemImage =  UIImage.init(contentsOfFile: Bundle.jx.getBundlePathResource(bundName: "", resourceName: ""))
        self.rootCloseItemImage =  UIImage.init(contentsOfFile: Bundle.jx.getBundlePathResource(bundName: "JSWebKit", resourceName: "rootback"))
        
    }
    
    
    
}
