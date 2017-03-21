//
//  ViewModelType.swift
//  Gank
//
//  Created by Maru on 2017/3/21.
//  Copyright © 2017年 Maru. All rights reserved.
//

import UIKit

protocol ViewModelType {
    
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
