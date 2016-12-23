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
import PullToRefresh

final class HomeViewController: UIViewController {
    
    let segement = HMSegmentedControl().then {
        $0.sectionTitles = ["All","Android","iOS","休息视频","福利","拓展资源","前端","瞎推荐","App"]
        $0.selectionIndicatorColor = Config.UI.themeColor
    }
    
    let tableView = UITableView().then {
        $0.register(cellType: HomeTableViewCell.self)
    }
    
    let refreshControl = PullToRefresh()
    
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
                        
            tableView.estimatedRowHeight = 100
            tableView.addPullToRefresh(refreshControl, action: { [unowned self] in
                self.homeVM.refreshCommand.onNext(self.segement.selectedSegmentIndex)
            })
                                    
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
            
        }
        
        do /** Rx Config */ {
        
            // Input

            segement.rx.controlEvent(.valueChanged)
                .map({ self.segement.selectedSegmentIndex })
                .observeOn(MainScheduler.instance)
                .do(onNext: { (idx) in
                    self.tableView.startRefreshing(at: .top)
                }, onError: nil, onCompleted: nil, onSubscribe:nil,onDispose: nil)
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
                .subscribe { [unowned self] (event) in
                    self.tableView.endRefreshing(at: .top)
                    switch event {
                    case .error(_):
                        NoticeBar(title: "Network Disconnect!", defaultType: .error).show(duration: 2.0, completed: nil)
                        break
                    case .next(_):
                        self.tableView.reloadData()
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
                cell.gankAuthor.text = item.who
                cell.gankTime.text = item.publishedAt.toString(format: "YYYY/MM/DD")
                return cell
            }
        }
        
        self.tableView.startRefreshing(at: .top)

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
        return HomeTableViewCell.height
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
