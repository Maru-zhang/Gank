//
//  AppDelegate.swift
//  Gank
//
//  Created by Maru on 2016/11/30.
//  Copyright © 2016年 Maru. All rights reserved.
//

import UIKit
import Kingfisher
import SideMenu

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        setupConfig()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

extension AppDelegate {
    
    fileprivate func setupConfig() {
        
        do /** KingFisher Config */ {
            ImageCache.`default`.maxMemoryCost = UInt(30 * 1024 * 1024)
        }
        
        do /** Navgation Config */ {
            UINavigationBar.appearance().tintColor = Config.UI.titleColor
            UINavigationBar.appearance().isTranslucent = false
            UINavigationBar.appearance().barTintColor = Config.UI.themeColor
            UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: Config.UI.titleColor]
        }
        
        do /** SideMenu Config */ {
            SideMenuManager.menuAnimationBackgroundColor = Config.UI.themeColor
            SideMenuManager.menuFadeStatusBar = false
        }
    }
}

