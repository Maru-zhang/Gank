//
//  Brick.swift
//  Gank
//
//  Created by Maru on 2016/12/2.
//  Copyright © 2016年 Maru. All rights reserved.
//

import Foundation
import ObjectMapper

struct Brick: Equatable,Mappable {
    
    var _id: String         = ""
    var createdAt: String   = ""
    var desc: String        = ""
    var publishedAt: String = ""
    var source: String      = ""
    var type: String        = ""
    var url: String         = ""
    var used: String        = ""
    var who: String         = ""
    var images: [String]    = []
    
    public static func ==(lhs: Brick, rhs: Brick) -> Bool {
        return lhs._id == rhs._id ? true : false
    }
    
    init?(map: Map) { }
    
    init() { }
    
    mutating func mapping(map: Map) {
        _id <- map["id"]
        createdAt <- map["createdAt"]
        desc <- map["desc"]
        publishedAt <- map["publishedAt"]
        source <- map["source"]
        type <- map["type"]
        url <- map["url"]
        used <- map["used"]
        who <- map["who"]
        images <- map["images"]
    }
    
}
