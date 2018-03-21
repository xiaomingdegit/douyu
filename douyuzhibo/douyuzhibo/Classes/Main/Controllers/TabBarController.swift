//
//  TabBarController.swift
//  douyuzhibo
//
//  Created by 刘威 on 2018/3/21.
//  Copyright © 2018年 刘威. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setChildContorller()
    }
}

extension TabBarController{
    //设置tabBarController的子控制器
    fileprivate func setChildContorller() {
        let childControllerInfos = [
        ["controllerName": "HomeController", "title":"首页", "imageName":"btn_home_normal"],
        ["controllerName": "FollowController", "title":"直播", "imageName":"btn_column_normal"],
        ["controllerName": "LiveController", "title":"关注", "imageName":"btn_live_normal"],
        ["controllerName": "ProfileController", "title":"我的", "imageName":"btn_user_normal"]
        ]
        var childControllers = [UIViewController]()
        for info in childControllerInfos {
            let childController = setItemInfo(info: info)
            childControllers.append(childController)
        }
        self.viewControllers = childControllers
    }
    
    //根据传入的info设置viewController相应属性
    fileprivate func setItemInfo(info:[String: Any]) -> UIViewController {
        //提取info字典信息
        guard let controllerName = info["controllerName"] as? String,
              //通过controllerName获取相应类
              let cls =  NSClassFromString(Bundle.main.namespace + "." + controllerName) as? UIViewController.Type,
              let title = info["title"] as? String,
              let imageName = info["imageName"] as? String else {
            return UIViewController()
        }
        //创建相应控制器 并设置tabBarItem属性
        let viewController = cls.init()
        viewController.title = title
        viewController.tabBarItem.image = UIImage(named: imageName)
        //返回用navigationController包装后的控制器
        return UINavigationController.init(rootViewController: viewController);
    }
}
