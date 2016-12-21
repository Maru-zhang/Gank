//
//  HomeViewController.swift
//  Gank
//
//  Created by Maru on 2016/12/1.
//  Copyright © 2016年 Maru. All rights reserved.
//

import UIKit
import SwiftWebVC
import HMSegmentedControl
import EZSwiftExtensions
import Then
import SnapKit
import Reusable
import RxSwift
import RxCocoa
import Kingfisher
import NoticeBar

final class HomeViewController: UIViewController {
    
    let segement = HMSegmentedControl().then {
        $0.sectionTitles = ["All","Android","iOS","休息视频","福利","拓展资源","前端","瞎推荐","App"]
        $0.selectionIndicatorColor = Config.UI.themeColor
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension HomeViewController {
    
    // MARK: - Private Method
    
    fileprivate func setup() {
        
        do /** UI Config */ {
                        
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
            
            segement.indexChangeBlock = { [unowned self] idx in
                self.homeVM.refreshCommand.onNext(idx)
            }
                    
        }
        
        do /** Rx Config */ {
        
            // Input
            
            refreshControl.rx.controlEvent(.valueChanged)
                .map({ () -> Int in
                    return self.segement.selectedSegmentIndex
                })
                .bindTo(homeVM.refreshCommand)
                .addDisposableTo(rx_disposeBag)
            
            // Output
            
            homeVM.section
                .drive(tableView.rx.items(dataSource: homeVM.dataSource))
                .addDisposableTo(rx_disposeBag)
            
            tableView.rx.setDelegate(self)
                .addDisposableTo(rx_disposeBag)
            
            homeVM.refreshTrigger
                .observeOn(MainScheduler.instance)
                .subscribe { [weak self] (event) in
                    self?.refreshControl.endRefreshing()
                    switch event {
                    case .error(_):
                        NoticeBar(title: "Network Disconnect!", defaultType: .error).show(duration: 2.0, completed: nil)
                        break
                    case .next(_):
                        self?.tableView.reloadData()
                        break
                    default:
                        break
                    
                    }
                }
                .addDisposableTo(rx_disposeBag)
            
            // Configure
            
            homeVM.dataSource.configureCell = { dataSource, tableView, indexPath, item in
                let cell = tableView.dequeueReusableCell(for: indexPath, cellType: HomeTableViewCell.self)
                cell.gankTitle?.text = item.desc
                if item.images.count > 0 {
                    cell.gankImage?.kf.setImage(with: URL(string: item.images.first!))
                }
                cell.gankAuthor.text = item.who
                return cell
            }
        }
        
        tableView.refreshControl?.beginRefreshing()
        homeVM.refreshCommand.onNext(0)
    }
    
}

extension HomeViewController {
    
    // MARK: - Private Methpd
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
}

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return HomeTableViewCell.height + 200
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = homeVM.dataSource.sectionModels[0].items[indexPath.row]
        let webActivity = BrowserWebViewController(url: URL(string: item.url) ?? URL(string: "")!)
        navigationController?.pushViewController(webActivity, animated: true)
    }
}
