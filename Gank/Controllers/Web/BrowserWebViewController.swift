//
//  BrowserWebViewController.swift
//  Gank
//
//  Created by Maru on 2016/12/21.
//  Copyright © 2016年 Maru. All rights reserved.
//

import UIKit
import SnapKit
import WebKit

final class BrowserWebViewController: UIViewController {

    let webView = WKWebView()
    var webURL: URL
    init(url: URL) {
        webURL = url
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        do /** Config UI */ {
            webView.navigationDelegate = self
            webView.uiDelegate = self
            view.addSubview(webView)
            webView.snp.makeConstraints({ (make) in
                make.edges.equalTo(view)
            })
        }
        do /** Config Data */ {
            webView.load(URLRequest(url: webURL))
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

}

extension BrowserWebViewController: WKUIDelegate {

}

extension BrowserWebViewController: WKNavigationDelegate {

    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }

    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        webView.evaluateJavaScript("document.title", completionHandler: {(response, _) in
            self.title = response as? String
        })
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}
