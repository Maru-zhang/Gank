//
//  HomeTableViewCell.swift
//  Gank
//
//  Created by Maru on 2016/12/2.
//  Copyright © 2016年 Maru. All rights reserved.
//

import UIKit
import Reusable

final class HomeTableViewCell: UITableViewCell,NibReusable {
    
    static let height: CGFloat = 100.0
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        HomeTableViewCell.loadFromNib(owner: self)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
