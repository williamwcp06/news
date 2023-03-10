//
//  ArticleDetailPresenter.swift
//  News
//
//  Created by William on 10/03/23.
//

import Foundation

class ArticleDetailPresenter: ArticleDetailPresenterProtocol {
    var view: ArticleDetailViewControllerProtocol?
    var interactor: ArticleDetailInteractorProtocol?
    var router: ArticleDetailRouterProtocol?
    
    func viewDidLoad() {
        view?.initUI()
        view?.showLoading()
        view?.loadWebView()
    }
    
    func getUrl() -> String {
        return interactor?.article.url ?? ""
    }
}

extension ArticleDetailPresenter: ArticleDetailInteractorOutputProtocol {
    
}
