//
//  ViewController.swift
//  News
//
//  Created by William on 09/03/23.
//

import UIKit
import SnapKit

class ArticleVC: BaseVC {
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search here"
        searchBar.delegate = self
        return searchBar
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(CommonTableViewCell.self, forCellReuseIdentifier: CommonTableViewCell.nameOfClass)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    var viewModel: ArticleVM!
    
    override func initSubview() {
        super.initSubview()
        view.addSubview(searchBar)
        searchBar.snp.makeConstraints{
            $0.left.right.equalToSuperview().inset(20)
            $0.top.equalToSuperview().inset(ScreenSize.navigationBar+20)
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints{
            $0.top.equalTo(searchBar.snp.bottom).inset(-10)
            $0.left.right.bottom.equalToSuperview()
        }
    }
    
    override func initBinding() {
        super.initBinding()
        
        getArticle()
        
        viewModel.completionReloadData = { [weak self] in
            guard let self else { return }
            self.reloadData()
        }
        
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(endEditing)))
    }
    
    override func setData() {
        super.setData()
        title = "Article(s)"
    }
    
    private func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    private func getArticle(showLoading: Bool = true) {
        if showLoading {
            self.showLoading()
        }
        viewModel.getArticle() { [weak self] error in
            guard let self else { return }
            self.hideLoading()
            if let error {
                let reload = UIAlertAction(title: "Reload", style: .default) { _ in
                    self.getArticle()
                }
                let ok = UIAlertAction(title: "OK", style: .default)
                DispatchQueue.main.async {
                    let _ = self.createAlert(title: "\(error.errorCode)", message: error.errorDescription, action: [reload, ok])
                }
                return
            }
            self.reloadData()
        }
    }
    
    private func gotoArticleDetail(with indexPath: IndexPath) {
        guard let url = viewModel.articlesFiltered[indexPath.row].url else {
            let _ = createAlert(message: "This article dont have a detail")
            return
        }
        let vc = ArticleDetailVC()
        vc.url = url
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


extension ArticleVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.articlesFiltered.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CommonTableViewCell.nameOfClass) as? CommonTableViewCell else { return UITableViewCell() }
        let data = viewModel.articlesFiltered[indexPath.row]
        cell.setData(data.urlToImage, title: data.title, desc: data.description)
        cell.completionSelect = { [weak self] in
            guard let self else { return }
            self.gotoArticleDetail(with: indexPath)
        }
        
        if viewModel.needLoadMore(index: indexPath.row) {
            getArticle()
        }
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        endEditing()
    }
}

extension ArticleVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchArticle(searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        endEditing()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        endEditing()
    }
}
