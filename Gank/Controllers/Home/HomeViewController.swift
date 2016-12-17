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
        
        // Input
        
        refreshControl.rx.controlEvent(.valueChanged)
            .bindTo(homeVM.refreshCommand)
            .addDisposableTo(rx_disposeBag)
        
        // Output

        homeVM.section
            .drive(tableView.rx.items(dataSource: homeVM.dataSource))
            .addDisposableTo(rx_disposeBag)
        
        tableView.rx.setDelegate(self)
            .addDisposableTo(rx_disposeBag)
        
        homeVM.refreshCommand.subscribe { [unowned self] (event) in
            print("dsadsadsa")
            switch event {
            case let .next(response):
                print(response)
//                print(String.init(data: response.data, encoding: .utf8) ?? "default string")
            case let .error(error):
                print(error)
            default:
                break
            }
            self.refreshControl.endRefreshing()
        }.addDisposableTo(rx_disposeBag)
        
        // Configure
        
        homeVM.dataSource.configureCell = { ds, tv, ip, item in
            let cell = tv.dequeueReusableCell(for: ip, cellType: HomeTableViewCell.self)
            return cell
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
