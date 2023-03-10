//
//  ArticleViewController.swift
//  News
//
//  Created by William on 10/03/23.
//

import Foundation

import UIKit
import SnapKit

class ArticleViewController: UIViewController {
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search here"
        searchBar.delegate = self
        return searchBar
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(CommonTableViewCell.self, forCellReuseIdentifier: CommonTableViewCell.nameOfClass)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.nameOfClass)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    var presenter: ArticlePresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
}

// MARK: - Protocol
extension ArticleViewController: ArticleViewControllerProtocol {
    func initUI() {
        title = "Article(s)"
        
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
        
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(endEditing)))
    }
    
    func showLoading() {
        LoadingIndicator.instance.showLoading(onView: view)
    }
    
    func hideLoading() {
        LoadingIndicator.instance.hideLoading()
    }
    
    func showError(error: AppError) {
        let _ = Alert.instance.createAlert(self, title: "\(error.errorCode)", message: error.errorDescription)
    }
    
    @objc func endEditing() {
        view.endEditing(true)
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension ArticleViewController: CommonTableViewCellProtocol {
    func didSelectCell(index: Int) {
        presenter.didSelectRowAt(index: index)
    }
}

// MARK: - Table View
extension ArticleViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return max(presenter.getArticlesFiltered()?.count ?? 0,1)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let articles = presenter.getArticlesFiltered(), articles.count == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.nameOfClass) else { return UITableViewCell() }
            cell.textLabel?.text = "Data is not available"
            return cell
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CommonTableViewCell.nameOfClass) as? CommonTableViewCell else { return UITableViewCell() }
        if let data = presenter.getArticlesFiltered()?[indexPath.row] {
            cell.setData(data.urlToImage ?? "", title: data.title, desc: data.description, index: indexPath.row)
        }
        cell.delegate = self
        if presenter.needLoadMore(index: indexPath.row) {
            presenter.fetchArticle()
        }
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        endEditing()
    }
}


//MARK: - Search Bar
extension ArticleViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter.getArticleBySearch(text: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        endEditing()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        endEditing()
    }
}
