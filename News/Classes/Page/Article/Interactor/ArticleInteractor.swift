//
//  ArticleInteractor.swift
//  News
//
//  Created by William on 10/03/23.
//

import Foundation

class ArticleInteractor: ArticleInteractorProtocol {
    var articles: [ArticleModel]?
    var articlesFiltered: [ArticleModel]?
    var presenter: ArticleInteractorOutputProtocol?
    var source: SourceModel!
    var stopLoadMore: Bool = false
    
    func fetchArticle() {
        var params: [String : String] = [:]
        params["sources"] = source.id
        params["pageSize"] = "\(PageSize)"
        params["page"] = "\(((articles?.count ?? 0)/PageSize)+1)"
        stopLoadMore = true
        ApiManager.instance.makeRequest(url: URLConstant.articleUrl, params: params, model: ArticleResponseModel.self) { [weak self] error, result in
            guard let self else { return }
            if let error {
                self.presenter?.fetchFailedArticle(error: error)
            }
            
            if let articles = result?.articles {
                self.articles = (self.articles ?? []) + articles
                self.articlesFiltered = self.articles
                self.presenter?.fetchSuccessArticle()
            }
            self.stopLoadMore = result?.articles.isEmpty ?? false
        }
    }
    
    func getArticleBySearch(text: String) {
        if text == "" || text.isEmpty {
            articlesFiltered = articles
        } else {
            articlesFiltered = articles?.filter{
                ($0.title?.localizedCaseInsensitiveContains(text) ?? false) || ($0.source?.name?.localizedCaseInsensitiveContains(text) ?? false) || ($0.author?.localizedCaseInsensitiveContains(text) ?? false)
            }
        }
        presenter?.fetchSuccessArticle()
    }
    
    func needLoadMore(index: Int) -> Bool {
        guard index > 0 else { return false }
        guard !stopLoadMore else { return false}
        return (articlesFiltered?.count ?? 0) - 5 < index
    }
    
    
}
