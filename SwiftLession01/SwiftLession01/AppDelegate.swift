//
//  AppDelegate.swift
//  SwiftLession01
//
//  Created by wjx on 2021/12/13.
//

import JLRoutes
import UIKit
import SwiftEventBus

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    static var ON_START_RECORD:String = "ON_START_RECORD"
    var window : UIWindow?
    let tabbarVC = BubbleTabBarController()
     let  utils = Utils()
    private var navigator: NavigatorProtocol?
    
    var nav : UINavigationController?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        print(NSHomeDirectory())
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(doSomethingMethod),
            name: NSNotification.Name(rawValue: ThemeUpdateNotification),
            object: nil
        )
        
        SwiftEventBus.onMainThread(self, name: AppDelegate.ON_START_RECORD) { result in
            print("下载成功 更新")
            PackageManager.getInstance.update(packageIndexStr: result?.object as! String);
            
        }
        PackageManager.getInstance.inits()
        getPackageIndex(url: Constants.BASE_PACKAGE_INDEX);
        
        // default: Red.json
        Themes.restoreLastTheme()
//        ThemeManager.setTheme(jsonName: "Red", path: .mainBundle)
//        Themes.restoreLastTheme()
        
        // status bar
        
        setHome()
        //添加推送消息
        Pusher.registerRemoteService()
        //初始化路由
        //查询远程路由 下载最新
//        downloadRouters()
        WJXVCRouterConfig.configMapInfo()
        
        HTSDKEngine.initSDKEnvironment()
        
        let presetApplistPath = Bundle.jx.getBundlePathResource(bundName: "HTCustomPresetApps", resourceName: "h5_json.json", bundleType: .currentBundle)
//        utils.loadFileContent(path: "HTCustomPresetApps.bundle/h5_json.json")
        let appPackagePath = Bundle.jx.getBundlePathResource(bundName: "MPCustomPresetApps", resourceName: "")
//        utils.loadFileContent(path:"MPCustomPresetApps.bundle")
        let pluginsJsapisPath = Bundle.jx.getBundlePathResource(bundName: "MPCustomPlugins", resourceName: "Poseidon-UserDefine-Extra-Config")
//        utils.loadFileContent(path:"Poseidon-UserDefine-Extra-Config.plist")
        
        HTSDKEngine.initNebulaWithCustomPresetApplistPath(customPresetApplistPath: presetApplistPath, customPresetAppPackagePath: appPackagePath, customPluginsJsapisPath: pluginsJsapisPath)
        
        
        
//        self.window.rootViewController = vc
        return true
    }
    func getPackageIndex(url:String){
        let thread = Thread(target: self, selector: #selector(threadExecute), object: url)
        thread.start()
    }
    @objc func threadExecute(url:String) {
        
        
        Mesh.downLoadWithConfig { config in
            config.URLString = url
            config.requestMethod = .get
            config.destination = {(temporaryURL, response) in
                var documentsPath = FileUtils.getPackageRootPath()+"/"

                let pathComponent = response.suggestedFilename
                documentsPath.append(pathComponent!)
                
                return (URL(fileURLWithPath: documentsPath),[.removePreviousFile, .createIntermediateDirectories])
            }
//            let path = FileUtils.getPackageRootPath()
//
//            config.fileURL = URL(fileURLWithPath:path)
        } progress: { progress in
            print(progress)
        } success: { config in
            print(config)
            SwiftEventBus.post(AppDelegate.ON_START_RECORD, sender: config.fileUrl)
        } failure: { config in
            
        }
            
//            Mesh.requestWithConfig { config in
//                config.URLString = url
//                config.requestMethod = .get
//            } success: { config in
//                guard let data = config.response?.data else{
//                    return
//                }
//                let dic = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
//                print("\(String(describing: dic?["holiday"]))")
//
//            } failure: { config in
//                print("error getHoliday")
//            }
            
            
           
        }
    
     func setHome(){
         
         window = UIWindow.init()
         UIApplication.shared.theme_setStatusBarStyle([.lightContent, .default, .lightContent, .lightContent], animated: true)
         
//        let mainViewController = ViewController()
      
         
        let eventsVC = ViewController()
        eventsVC.tabBarItem = UITabBarItem(title: "Events", image: #imageLiteral(resourceName: "dashboard"), tag: 0)
        eventsVC.inverseColor()
         nav = UINavigationController(rootViewController: eventsVC)
        
        
         let navigationBar = UINavigationBar.appearance()
//         navigationBar.theme_tintColor = GlobalPicker.barTextColor
//
//         navigationBar.theme_barTintColor = GlobalPicker.barTintColor
//         navigationBar.theme_titleTextAttributes = ThemeStringAttributesPicker.pickerWithAttributes(titleAttributes)
         
        // navigation bar
        
//        let navigationBar = UINavigationBar.appearance()
        
        nav!.navigationBar.theme_tintColor = "Global.barTextColor"
        nav!.navigationBar.theme_barTintColor = "Global.barTintColor"

//        nav.navigationBar.theme_backgroundColor = "Global.backgroundColor"
        nav!.navigationBar.theme_titleTextAttributes = ThemeStringAttributesPicker(keyPath: "Global.barTextColor") { value -> [NSAttributedString.Key : AnyObject]? in
            guard let rgba = value as? String else {
                return nil
            }

            let color = UIColor(rgba: rgba)
            let shadow = NSShadow(); shadow.shadowOffset = CGSize.zero
            let titleTextAttributes = [
                NSAttributedString.Key.foregroundColor: color,
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16),
                NSAttributedString.Key.shadow: shadow
            ]

            return titleTextAttributes
        }
        
        // tab bar
        
       

        tabbarVC.tabBar.theme_tintColor = "Global.barTextColor"
        tabbarVC.tabBar.theme_barTintColor = "Global.barTintColor"
        
       
        let searchVC = SampleViewController()
        searchVC.tabBarItem = UITabBarItem(title: "Search", image: #imageLiteral(resourceName: "clock"), tag: 3)
        let activityVC = SampleViewController()
        activityVC.tabBarItem = UITabBarItem(title: "Activity", image: #imageLiteral(resourceName: "folder"), tag: 0)
        let settingsVC = SampleViewController()
        settingsVC.tabBarItem = UITabBarItem(title: "Settings", image: #imageLiteral(resourceName: "menu"), tag: 0)
        settingsVC.tabBarItem.selectedImage =  #imageLiteral(resourceName: "clock")
        settingsVC.inverseColor()
        let items=[nav!,searchVC,activityVC,settingsVC];
        tabbarVC.viewControllers=items
        window!.rootViewController = tabbarVC
        window!.makeKeyAndVisible()
    }
    @objc func doSomethingMethod(obj :NSNotification){
        let value = obj.object as! Dictionary<String,Any>
//        let color = value?["barTextColor"]
        let global = value["Global"]as! Dictionary<String,Any>
        let barTintColor = global["barTintColor"]
        let barTextColor = global["barTextColor"]
        print(barTintColor!)
        if #available(iOS 13.0, *){
            let app = UINavigationBarAppearance()
            app.configureWithOpaqueBackground()  // 重置背景和阴影颜色
            app.titleTextAttributes = [
                  NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18),
                  NSAttributedString.Key.foregroundColor: UIColor(hexString:barTextColor! as! String) ?? UIColor.black // #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)

            ]
            app.backgroundColor =  UIColor(hexString: barTintColor! as! String)
            app.shadowColor = .clear
            
            
            
           let tabappearance = UITabBarAppearance()
            
            tabappearance.configureWithOpaqueBackground();
            tabappearance.backgroundColor =  UIColor( hexString:barTintColor! as! String);
            
            UITabBar.appearance().standardAppearance = tabappearance;
            
            /// 这里有点区别。导航栏是iOS13开始。这里是iOS15才有的
            if #available(iOS 15.0, *) {
                tabbarVC.tabBar.scrollEdgeAppearance = tabappearance
            }
            UINavigationBar.appearance().scrollEdgeAppearance = app  // 带scroll滑动的页面
            UINavigationBar.appearance().standardAppearance = app // 常规页面。描述导航栏以标准高度
            nav?.navigationBar.scrollEdgeAppearance = app;
            nav?.navigationBar.standardAppearance = app;
            
           window!.setNeedsLayout()
            
        }
        
        
    }
   
   

    func applicationWillTerminate(_ application: UIApplication) {
        Themes.saveLastTheme()
    }
    
    
    
    func application(
        _ app: UIApplication,
        open url: URL,
        options: [UIApplication.OpenURLOptionsKey: Any] = [:]
    ) -> Bool {
        // Try presenting the URL first
        if self.navigator?.present(url, wrap: UINavigationController.self) != nil {
            print("[Navigator] present: \(url)")
            return true
        }
        
        // Try opening the URL
        if self.navigator?.open(url) == true {
            print("[Navigator] open: \(url)")
            return true
        }
        
        return false
    }

}

