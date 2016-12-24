//
//  BaseNavigationController.swift
//  Gank
//
//  Created by Maru on 2016/12/24.
//  Copyright © 2016年 Maru. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var childViewControllerForStatusBarStyle: UIViewController? {
        return topViewController
    }
    
}
