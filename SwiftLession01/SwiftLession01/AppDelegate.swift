//
//  AppDelegate.swift
//  SwiftLession01
//
//  Created by wjx on 2021/12/13.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let mainViewController = ViewController()

        let nav = UINavigationController(rootViewController: mainViewController)
        
        window!.rootViewController = nav
        window?.makeKeyAndVisible()
       
        
//        self.window.rootViewController = vc
        
        return true
    }

   

   


}

