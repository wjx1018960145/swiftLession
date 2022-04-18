//
//  BundleExtensionViewController.swift
//  SwiftLession01
//
//  Created by wjx on 2022/4/15.
//

import UIKit

class BundleExtensionViewController: TestBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = []
        self.view.backgroundColor = UIColor.green
        
        headDataArray = ["一、Bundle 的基本扩展", "二、App的基本信息"]
        dataArray = [["从 Bundle 里面获取资源文件（支持当前的 Moudle下的Bundle和其他Moudle下的 Bundle）", "从其他的 Bundle 通过 bundlename 获取 bundle", "读取项目本地图片"], ["App命名空间", "项目/app 的名字", "获取app的版本号", "获取app的 Build ID", "获取app的 Bundle Identifier", "Info.plist", "App 名称"]]
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
// MARK: - 二、App的基本信息
extension BundleExtensionViewController {
    
    // MARK: 2.7、App 名称
    @objc func test27() {
        let appDisplayName = Bundle.jx.appDisplayName
        print("App 名称：\(appDisplayName)")
    }
    
    @objc func test26() {
        guard let infoDictionary = Bundle.jx.infoDictionary else {
            return
        }
        print("项目 Info.plist 打印" ,"\(infoDictionary)")
    }
    
    // MARK: 2.5、获取app的 Bundle Identifier
    @objc func test25() {
        print("获取app的 Bundle Identifier：\(Bundle.jx.appBundleIdentifier)")
    }
    
    // MARK: 2.4、获取app的 Build ID
    @objc func test24() {
        print("获取app的 Build ID：\(Bundle.jx.appBuild)")
    }
    
    // MARK: 2.3、获取app的版本号
    @objc func test23() {
        print("获取app的版本号：\(Bundle.jx.appVersion)")
    }
    
    // MARK: 2.2、项目/app 的名字
    @objc func test22() {
        print("项目/app 的名字：\(Bundle.jx.bundleName)")
    }
    
    // MARK: 2.1、App命名空间
    @objc func test21() {
        print("App命名空间：\(Bundle.jx.namespace)")
    }
}

// MARK: - 一、Bundle 的基本扩展
extension BundleExtensionViewController {
    
    // MARK: 1.3、读取项目本地图片
    @objc func test13() {
        let filePath = Bundle.main.path(forResource: "girl", ofType: "jpg")
    
        let image = UIImage(contentsOfFile: filePath ?? "")
        // girl.jpg
        var imageView2 = UIImageView(frame: CGRect(x: 0, y: 300, width: 150, height: 300))
        imageView2.jx.centerX = self.view.jx.centerX
        imageView2.backgroundColor = .red
        imageView2.image = image
        self.view.addSubview(imageView2)
        
        JXAsyncs.asyncDelay(2, {
        }) {
            imageView2.removeFromSuperview()
        }
    }
    
    // MARK: 1.2、从其他的 Bundle 通过 bundlename 获取 bundle
    @objc func test12() {
        
        // 当前 moudle 下的 bundle 图片
        let imagePath1 = Bundle.jx.getBundleResource(bundName: "JKBaseKit", resourceName: "icon_scan@2x", ofType: "png", bundleType: .currentBundle)
        // 其他 moudle 下的 bundle 图片
        let imagePath2 = Bundle.jx.getBundleResource(bundName: "MJRefresh", resourceName: "trail_arrow@2x", ofType: "png", bundleType: .otherBundle)
        
        var imageView1 = UIImageView(frame: CGRect(x: 0, y: 100, width: 100, height: 100))
        imageView1.jx.centerX = self.view.jx.centerX
        imageView1.backgroundColor = .red
        imageView1.image = UIImage(named: imagePath1 ?? "")

        var imageView2 = UIImageView(frame: CGRect(x: 0, y: 300, width: 100, height: 100))
        imageView2.jx.centerX = self.view.jx.centerX
        imageView2.backgroundColor = .red
        imageView2.image = UIImage(named: imagePath2 ?? "")
        self.view.addSubview(imageView1)
        self.view.addSubview(imageView2)
        
        JXAsyncs.asyncDelay(2, {
        }) {
            imageView1.removeFromSuperview()
            imageView2.removeFromSuperview()
        }
    }
    
    // MARK: 1.1、从 Bundle 里面获取资源文件（支持当前的 Moudle下的Bundle和其他Moudle下的 Bundle）
    @objc func test11() {
        // 当前 moudle 下的 bundle 图片
        let imagePath1 = Bundle.jx.getBundlePathResource(bundName: "JKBaseKit", resourceName: "icon_scan", bundleType: .currentBundle)
        // 其他 moudle 下的 bundle 图片
        let imagePath2 = Bundle.jx.getBundlePathResource(bundName: "MJRefresh", resourceName: "trail_arrow", bundleType: .otherBundle)
       
        var imageView1 = UIImageView(frame: CGRect(x: 0, y: 100, width: 100, height: 100))
        imageView1.jx.centerX = self.view.jx.centerX
        imageView1.backgroundColor = .red
        imageView1.image = UIImage(named: imagePath1)

        var imageView2 = UIImageView(frame: CGRect(x: 0, y: 300, width: 100, height: 100))
        imageView2.jx.centerX = self.view.jx.centerX
        imageView2.backgroundColor = .red
        imageView2.image = UIImage(named: imagePath2)
        self.view.addSubview(imageView1)
        self.view.addSubview(imageView2)
        
        JXAsyncs.asyncDelay(2, {
        }) {
            imageView1.removeFromSuperview()
            imageView2.removeFromSuperview()
        }
    }
}
