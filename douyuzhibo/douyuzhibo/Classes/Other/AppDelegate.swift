//
//  AppDelegate.swift
//  douyuzhibo
//
//  Created by 刘威 on 2018/3/21.
//  Copyright © 2018年 刘威. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        //设置tabBar上的图片不被渲染
        UITabBar.appearance().tintColor = UIColor.orange
        
        window = UIWindow(frame: UIScreen.main.bounds)
        //设置tabBarController为根控制器
        let tabBarController = TabBarController()
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        return true
    }

}

