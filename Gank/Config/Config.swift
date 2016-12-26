//
//  Config.swift
//  Gank
//
//  Created by Maru on 2016/12/21.
//  Copyright © 2016年 Maru. All rights reserved.
//

import Foundation

enum NotificationName: String {
    case homeCategory = "homeCategory"
}

struct Config {
    
    struct UI {
        
        /// Gank‘s ThemeColor
        static let themeColor = UIColor(r: 63.0, g: 63.0, b: 63.0, a: 1)
        /// Gank's Navgation Title Color
        static let titleColor = UIColor(r: 255, g: 255, b: 255, a: 1)
    }
    
    struct NotificationName {
        
        /// Gank post when home category change
        static let homeCategory = "homeCategory"
    }
}
