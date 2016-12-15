//
//  HomeViewController.swift
//  Gank
//
//  Created by Maru on 2016/12/1.
//  Copyright © 2016年 Maru. All rights reserved.
//

import UIKit
import HMSegmentedControl
import EZSwiftExtensions
import Then
import SnapKit
import Reusable
import RxSwift
import RxCocoa
import Moya
import ObjectMapper

final class HomeViewController: UIViewController {
    
    let segement = HMSegmentedControl().then {
        $0.sectionTitles = ["All","Android","iOS","休息视频","福利","拓展资源","前端","瞎推荐","App"]
    }
    
    let tableView = UITableView().then {
        $0.register(cellType: HomeTableViewCell.self)
    }
    
    let refreshControl = UIRefreshControl().then {
        $0.tintColor = UIColor.lightGray
    }
    
    let homeVM = HomeViewModel()
    
    let disposeBag = DisposeBag()

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
}

extension HomeViewController {
    
    // MARK: - Private Method
    
    fileprivate func setupUI() {
        
        tableView.refreshControl = refreshControl

        view.addSubview(segement)
        view.addSubview(tableView)

        segement.snp.makeConstraints { (make) in
            make.top.equalTo(view.snp.top).offset(20)
            make.left.right.equalTo(view)
            make.height.equalTo(50)
        }

        tableView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(view)
            make.top.equalTo(segement.snp.bottom)
        }
        
        // Binding
        
        Observable.just([homeVM.section])
            .bindTo(tableView.rx.items(dataSource: homeVM.dataSource))
            .addDisposableTo(disposeBag)
        
        tableView.rx.setDelegate(self)
            .addDisposableTo(disposeBag)
        
        // Configure
        
        homeVM.dataSource.configureCell = { ds, tv, ip, item in
            let cell = tv.dequeueReusableCell(for: ip, cellType: HomeTableViewCell.self)
            return cell
        }
        
        let _ = refreshControl.rx.refreshing
        
        let provider = RxMoyaProvider<GankAPI>()
        provider.request(.data(type: .iOS, size: 20, index: 0)).map { (res) -> () in
            debugPrint(res)
            return ()
        }
        
    }
    
}

extension HomeViewController {
    
    // MARK: - Private Methpd
    
    fileprivate func refreshAction() {
        
    }
}

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return HomeTableViewCell.height
    }

}
