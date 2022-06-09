//
//  AppDelegate.swift
//  SwiftLession01
//
//  Created by wjx on 2021/12/13.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window : UIWindow?
    let tabbarVC = BubbleTabBarController()
    var nav : UINavigationController?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(doSomethingMethod),
            name: NSNotification.Name(rawValue: ThemeUpdateNotification),
            object: nil
        )
        // default: Red.json
        Themes.restoreLastTheme()
//        ThemeManager.setTheme(jsonName: "Red", path: .mainBundle)
//        Themes.restoreLastTheme()
        
        // status bar
        
        setHome()
//        self.window.rootViewController = vc
        return true
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

}

