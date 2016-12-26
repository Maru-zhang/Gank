//
//  SideViewController.swift
//  Gank
//
//  Created by Maru on 2016/12/24.
//  Copyright © 2016年 Maru. All rights reserved.
//

import UIKit

class SideViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension SideViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NotificationCenter.default.post(name: NSNotification.Name.category, object: indexPath)
    }
}
