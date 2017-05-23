//
//  HomeTableViewCell.swift
//  Gank
//
//  Created by Maru on 2016/12/2.
//  Copyright © 2016年 Maru. All rights reserved.
//

import UIKit
import Reusable

final class HomeTableViewCell: UITableViewCell, NibReusable {

    @IBOutlet weak var gankTitle: UILabel!
    @IBOutlet weak var gankAuthor: UILabel!
    @IBOutlet weak var gankTime: UILabel!

    static let height: CGFloat = UITableViewAutomaticDimension

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
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
