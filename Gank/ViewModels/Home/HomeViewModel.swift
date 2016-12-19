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

class HomeViewModel: NSObject {
    
    /// 首页干货
    
    let section: Driver<[HomeSection]>
    
    let refreshCommand = PublishSubject<Void>()
    
    let refreshTrigger = PublishSubject<Void>()
    
    let dataSource = RxTableViewSectionedReloadDataSource<HomeSection>()
    
    fileprivate let bricks = Variable<[Brick]>([])
    
    fileprivate let disposeBag = DisposeBag()
    
    override init() {
        
        section = bricks.asObservable().map({ (bricks) -> [HomeSection] in
            return [HomeSection(header: "", items: bricks)]
        })
        .asDriver(onErrorJustReturn: [])
    
        super.init()
        
        refreshCommand
            .flatMapLatest { gankApi.request(.data(type: .Android, size: 20, index: 0)) }
            .subscribe({ [weak self] (event) in
                print("got data");
                self?.refreshTrigger.onNext()
                switch event {
                case let .next(response):
                    do {
                        let data = try response.mapArray(Brick.self)
                        self?.bricks.value = data
                    }catch {
                        self?.bricks.value = []
                    }
                    break
                case let .error(_):
                    break
                default:
                    break
                }
            })
            .addDisposableTo(rx_disposeBag)
        
        
    }
    
}


