//
//  HomeViewModel.swift
//  Gank
//
//  Created by Maru on 2016/12/7.
//  Copyright © 2016年 Maru. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

//struct MySection {
//    var header: String
//    var items: [Item]
//}
//
//extension MySection : AnimatableSectionModelType {
//    typealias Item = Int
//    
//    var identity: String {
//        return header
//    }
//    
//    init(original: MySection, items: [Item]) {
//        self = original
//        self.items = items
//    }
//}


struct HomeSection {
    
    var items: [Item]
}

extension HomeSection: AnimatableSectionModelType {
    
    typealias Item = Int

    var identity: String {
        return String(describing: HomeSection.self)
    }
    
    init(original: HomeSection, items: [HomeSection.Item]) {
        self = original
        self.items = items
    }
}

class HomeViewModel {
    
    /// 首页干货
//    let dataSource = Variable<[Brick]>([])
    
    let refreshCommand = PublishSubject<Void>()
    
    let dataSource = RxTableViewSectionedAnimatedDataSource<HomeSection>()
    
    
    init() {
        
    
    }

}
