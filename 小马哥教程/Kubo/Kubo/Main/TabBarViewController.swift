//
//  TabBarViewController.swift
//  Kubo
//
//  Created by wjx on 2023/9/21.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setValue(TabBar(), forKey: "tabBar")
        
        
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.backgroundColor = UIColor.white
            UITabBar.appearance().standardAppearance  = tabBarAppearance
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.backgroundColor = UIColor.white
            UINavigationBar.appearance().standardAppearance  = navBarAppearance
            UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        
        tabBar.tintColor = UIColor.black
        addChild("糗事", "icon_main", "icon_main_active", HomeViewController.self)
        addChild("动态", "main_tab_qbfriends", "main_tab_qbfriends_active", TrendViewController.self)
        addChild("直播", "main_tab_live", "main_tab_live_active", LiveViewController.self)
    
        

        // Do any additional setup after loading the view.
    }
    
    func addChild(_ title:String,_ image:String,_ selectImage:String,_ type:UIViewController.Type){
        
      
        
        let child = UINavigationController(rootViewController: type.init())
        child.title = title
        child.tabBarItem.image = UIImage(named: image)
        child.tabBarItem.selectedImage = UIImage(named: selectImage)
        child.tabBarItem.setTitleTextAttributes([
        
            NSAttributedString.Key.foregroundColor:UIColor.black
            
        ], for: .selected)
        addChild(child)
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
