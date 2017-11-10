//
//  MainTabBarViewController.swift
//  微博
//
//  Created by  ZhouYingJie on 16/5/30.
//  Copyright © 2016年 ZhouYingJie. All rights reserved.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupTabBar()
        self.config()
    }  
}

private extension MainTabBarViewController {
    func config(){
        self.tabBar.tintColor = MAINCOLOR
        //背景颜色白色
        let bgView = UIView.init(frame: self.tabBar.bounds)
        bgView.alpha = 0.8
        bgView.backgroundColor = WHITECOLOR
        self.tabBar.insertSubview(bgView, atIndex: 0)
        self.tabBar.opaque = true
    }
}

private extension MainTabBarViewController {

    func setupTabBar(){
        let homeVc = HomeViewController()
        let homeNav = JTNavigationController.init(rootViewController: homeVc)
        
        let newsVc = NewsViewController()
        let newsNav = JTNavigationController.init(rootViewController: newsVc)
        
        let findVc = FindViewController()
        let findNav = JTNavigationController.init(rootViewController: findVc)
        
        let mineVc = TeacherHomePageMoreVC()
        let mineNav = JTNavigationController.init(rootViewController: mineVc)
        
        let views = [homeNav,newsNav,findNav,mineNav]
        self.viewControllers = views
        
        let titles = ["首页","消息","发现","我"]
        let normalsImages = ["tabbar_home","tabbar_message_center","tabbar_discover","tabbar_profile"]
        let selectImages = ["tabbar_home_selected","tabbar_message_center_selected","tabbar_discover_selected","tabbar_profile_selected"]
        
        for(index, value) in views.enumerate() {
            value.tabBarItem.title = titles[index]
            value.tabBarItem.image = setImage(normalsImages[index])
            value.tabBarItem.selectedImage = setImage(selectImages[index])
            value.tabBarItem.image = value.tabBarItem.image?.imageWithRenderingMode(.AlwaysOriginal)
            value.tabBarItem.selectedImage = value.tabBarItem.selectedImage?.imageWithRenderingMode(.AlwaysOriginal)
            value.tabBarItem.imageInsets = UIEdgeInsetsMake(2, 0, -2, 0)
        }
    }
}