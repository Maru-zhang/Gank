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
import Moya
import RxSwift

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

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
}

extension HomeViewController {
    
    // MARK: - Private Method
    
    fileprivate func setupUI() {
        
        tableView.delegate = self
        tableView.dataSource = self
        
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
        
//        let provider = RxMoyaProvider<GankAPI>()
//        provider.request(.data(type: "Android", size: 20, index: 0)).subscribe { event in
//            switch event {
//            case let .next(response):
//                print(String.init(data: response.data, encoding: .utf8))
//            case let .error(error):
//                print(error)
//            default:
//                break
//            }
//        }
        
    }
    
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Private Method
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: HomeTableViewCell.self)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return HomeTableViewCell.height
    }

}
