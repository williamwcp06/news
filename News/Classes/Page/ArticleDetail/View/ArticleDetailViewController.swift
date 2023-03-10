//
//  ArticleDetailVC.swift
//  News
//
//  Created by William on 09/03/23.
//

import Foundation
import SnapKit
import WebKit

class ArticleDetailViewController: UIViewController {
    private lazy var webView: WKWebView = {
        let webConfiguration = WKWebViewConfiguration()
        let webView = WKWebView(frame: self.view.bounds, configuration: webConfiguration)
        webView.navigationDelegate = self
        return webView
    }()
    
    var presenter: ArticleDetailPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
}

extension ArticleDetailViewController: ArticleDetailViewControllerProtocol {
    func initUI() {
        title = "Detail"
        view.addSubview(webView)
        webView.snp.makeConstraints{
            $0.top.equalToSuperview().inset(navigationBarHeight)
            $0.left.bottom.right.equalToSuperview()
        }
    }
    
    func loadWebView() {
        guard let url = URL(string: presenter.getUrl()) else {
            hideLoading()
            return
        }
        let request = URLRequest(url: url)
        self.webView.load(request)
    }
    
    func showLoading() {
        LoadingIndicator.instance.showLoading(onView: view)
    }
    
    func hideLoading() {
        LoadingIndicator.instance.hideLoading()
    }
}

//MARK: - Webview Delegate
extension ArticleDetailViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        hideLoading()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        hideLoading()
    }
}
