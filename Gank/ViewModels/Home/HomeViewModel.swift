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
import Moya

struct HomeSection {
    
    var header: String
    var items: [Item]
}

extension HomeSection: SectionModelType {
    
    typealias Item = Brick
    
    init(original: HomeSection, items: [HomeSection.Item]) {
        self = original
        self.items = items
    }
}

class HomeViewModel {
    
    /// 首页干货
    
    let section = HomeSection(header: "", items: [Brick()])
    
    let refreshCommand = PublishSubject<Void>()
    
    let dataSource = RxTableViewSectionedReloadDataSource<HomeSection>()
    
    fileprivate let disposeBag = DisposeBag()

    
    
    init() {
    
        
        refreshCommand.subscribe { [unowned self] (_) in
            
            let provider = RxMoyaProvider<GankAPI>()
            provider.request(.data(type: .iOS, size: 20, index: 0)).subscribe { event in
                switch event {
                case let .next(response):
                    print(String.init(data: response.data, encoding: .utf8))
                case let .error(error):
                    print(error)
                default:
                    break
                }
            }.addDisposableTo(self.disposeBag)

        }.addDisposableTo(disposeBag)
    }
    

}
