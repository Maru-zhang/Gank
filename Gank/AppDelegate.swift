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
            SideMenuManager.menuWidth = 100.0
            SideMenuManager.menuFadeStatusBar = false
        }
    }
}
