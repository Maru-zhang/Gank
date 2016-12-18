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
    
    let dataSource = RxTableViewSectionedReloadDataSource<HomeSection>()
    
    fileprivate let bricks = Variable<[Brick]>([])
    
    fileprivate let disposeBag = DisposeBag()
    
    override init() {
        
        section = bricks.asObservable().map({ (bricks) -> [HomeSection] in
            return [HomeSection(header: "", items: bricks)]
        })
        .asDriver(onErrorJustReturn: [])
    
        super.init()
        
//        refreshCommand.subscribe { [unowned self] (_) in
//        
//            let provider = RxMoyaProvider<GankAPI>()
//            provider.request(.data(type: .iOS, size: 20, index: 0)).subscribe { event in
//                switch event {
//                case let .next(response):
//                    print(String.init(data: response.data, encoding: .utf8))
//                case let .error(error):
//                    print(error)
//                default:
//                    break
//                }
//            }.addDisposableTo(self.rx_disposeBag)
//
//        }.addDisposableTo(rx_disposeBag)
        
//        refreshCommand.map { (_) -> Observable<Response> in
//            return RxMoyaProvider<GankAPI>().request(.data(type: .iOS, size: 20, index: 0))
//        }
        
        refreshCommand
            .flatMapLatest { (_) -> Observable<Response> in
                return gankApi.request(.data(type: .iOS, size: 20, index: 0))
        }
            .subscribe(onNext: { (_) in
                print("NEXT")
            }, onError: { (_) in
                print("error")
            }, onCompleted: { 
                print("completed")
            }) { 
                print("dispose")
        }
            .addDisposableTo(rx_disposeBag)
        
        
    }
    
}


