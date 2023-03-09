//
//  NewsSourceVC.swift
//  News
//
//  Created by William on 09/03/23.
//

import UIKit
import SnapKit

class NewsSourceVC: BaseVC {
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
    
    var viewModel: NewsSourceVM!
    
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
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(endEditing)))
        
        getNewsSources()
        
        viewModel.completionReloadData = { [weak self] in
            guard let self else { return }
            self.reloadData()
        }
    }
    
    override func setData() {
        super.setData()
        title = "Sources"
    }
    
    private func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    private func getNewsSources(showLoading: Bool = true) {
        if showLoading {
            self.showLoading()
        }
        viewModel.getNewsSources { [weak self] error in
            guard let self else { return }
            self.hideLoading()
            if let error {
                let reload = UIAlertAction(title: "Reload", style: .default) { _ in
                    self.getNewsSources()
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
    
    private func gotoArticle(with indexPath: IndexPath) {
        let vc = ArticleVC()
        vc.viewModel = ArticleVM(category: viewModel.category, source: viewModel.sourcesFiltered[indexPath.row])
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}


extension NewsSourceVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.sourcesFiltered.count
    }
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CommonTableViewCell.nameOfClass) as? CommonTableViewCell else { return UITableViewCell() }
        let data = viewModel.sourcesFiltered[indexPath.row]
        cell.setData(nil, title: data.name, desc: data.description)
        cell.completionSelect = { [weak self] in
            guard let self else { return }
            self.gotoArticle(with: indexPath)
        }
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        endEditing()
    }
}

extension NewsSourceVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchSources(searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        endEditing()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        endEditing()
    }
}

