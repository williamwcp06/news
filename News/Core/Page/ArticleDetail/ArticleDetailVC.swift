//
//  ArticleDetailVC.swift
//  News
//
//  Created by William on 09/03/23.
//

import Foundation
import SnapKit
import WebKit

class ArticleDetailVC: BaseVC {
    private lazy var webView: WKWebView = {
        let webConfiguration = WKWebViewConfiguration()
        let webView = WKWebView(frame: self.view.bounds, configuration: webConfiguration)
        return webView
    }()
    
    lazy var url: String = ""
    
    override func initSubview() {
        super.initSubview()
        view.addSubview(webView)
        webView.snp.makeConstraints{
            $0.left.top.bottom.right.equalToSuperview()
        }
    }
    
    override func setData() {
        super.setData()
        title = "Detail"
        guard let _url = URL(string: url) else { return }
        let request = URLRequest(url: _url)
        self.webView.load(request)
    }
}
