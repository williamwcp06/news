//
//  ArticlePresenter.swift
//  News
//
//  Created by William on 10/03/23.
//

import Foundation

class ArticlePresenter: ArticlePresenterProtocol {
    var view: ArticleViewControllerProtocol?
    var interactor: ArticleInteractorProtocol?
    var router: ArticleRouterProtocol?
    
    func viewDidLoad() {
        view?.initUI()
        view?.showLoading()
        fetchArticle()
    }
    
    func fetchArticle() {
        interactor?.fetchArticle()
    }
    
    func getArticlesFiltered() -> [ArticleModel]? {
        return interactor?.articlesFiltered
    }
    
    func getArticleBySearch(text: String) {
        interactor?.getArticleBySearch(text: text)
    }
    
    func didSelectRowAt(index: Int) {
        guard let view else { return }
        guard let article = interactor?.articlesFiltered?[index] else { return }
        router?.pushToArticleDetail(on: view, with: article)
    }
    
    func needLoadMore(index: Int) -> Bool {
        guard let interactor else { return false }
        return interactor.needLoadMore(index: index)
    }
}

extension ArticlePresenter: ArticleInteractorOutputProtocol {
    func fetchSuccessArticle() {
        view?.reloadData()
        view?.hideLoading()
    }
    
    func fetchFailedArticle(error: AppError) {
        view?.showError(error: error)
        view?.hideLoading()
    }
    
}
