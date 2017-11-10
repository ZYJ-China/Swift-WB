    //
//  AppDelegate.swift
//  微博
//
//  Created by  ZhouYingJie on 16/5/30.
//  Copyright © 2016年 ZhouYingJie. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var tabBar:MainTabBarViewController!
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        self.window = UIWindow.init(frame: UIScreen.mainScreen().bounds)
        self.window!.backgroundColor = WHITECOLOR

        UserManager.sharedInstance.curUserInfo = UserManager.sharedInstance.loadUserData()
        
        if ((UserManager.sharedInstance.curUserInfo?.uid!.isEmpty) != nil) {
            setRootController()
        }else{
            let oauthNav = UINavigationController.init(rootViewController: OauthViewController())
            self.window?.rootViewController = oauthNav
        }
        
        //获取表情
        self.getEmotions()

        let search = "https://api.weibo.com/2/search/suggestions/users.json"
        var params = [String:NSObject]()
        params["access_token"] = UserManager.sharedInstance.curUserInfo?.access_token

        NetManager.GET(search, params: params, success: { (result) in
            print(result)
            }) { (error) in
                
        }
        
        
        
        return true
    }

    
    func setRootController() {
        tabBar = MainTabBarViewController()
        self.window?.rootViewController = tabBar
    }
    
    func getEmotions(){
        if let emtions = USERDEFAULRTS.valueForKey("emotions"){
            if emtions.count == 0 {
                StatusModel.getEmotionsWithSuccess { (result) in
                    USERDEFAULRTS.setValue(result, forKey: "emotions")
                    USERDEFAULRTS.synchronize()
                }
            }
        }
        
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

