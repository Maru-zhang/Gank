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
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
}

extension HomeViewController {
    
    // MARK: - Private Method
    
    fileprivate func setup() {
        
        // UI Config
        do {
                        
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
            
            tableView.delegate = self
            tableView.dataSource = self
        }
        
        // Rx Config
        do {
        
            // Input
            
            refreshControl.rx.controlEvent(.valueChanged)
                .bindTo(homeVM.refreshCommand)
                .addDisposableTo(rx_disposeBag)
            
            // Output
            
//            homeVM.section
//                .drive(tableView.rx.items(dataSource: homeVM.dataSource))
//                .addDisposableTo(rx_disposeBag)
//            
//            tableView.rx.setDelegate(self)
//                .addDisposableTo(rx_disposeBag)
            
            homeVM.refreshTrigger
                .observeOn(MainScheduler.instance)
                .subscribe { [weak self] (event) in
                    print("end refresh")
                    self?.tableView.reloadData()
                    self?.refreshControl.endRefreshing()
                }
                .addDisposableTo(rx_disposeBag)
            
            // Configure
            
            homeVM.dataSource.configureCell = { dataSource, tableView, indexPath, item in
                let cell = tableView.dequeueReusableCell(for: indexPath, cellType: HomeTableViewCell.self)
                cell.gankTitle.text = item.desc
                return cell
            }
        }
        
//        tableView.refreshControl?.beginRefreshing()
    }
    
}

extension HomeViewController {
    
    // MARK: - Private Methpd
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return HomeTableViewCell.height
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(for: indexPath, cellType: HomeTableViewCell.self)
    }

}
