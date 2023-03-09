//
//  NewsVM.swift
//  News
//
//  Created by William on 09/03/23.
//

import Foundation

protocol ArticleVMProtocol {
    var completionReloadData: (()->())? { get }
    var stopLoadMore: Bool { get set }
    var category: String { get set }
    var source: NewsSourceModel { get set }

    var articles: [ArticleModel] { get set }
    var articlesFiltered: [ArticleModel] { get set }
    
    func getArticle(completion: @escaping((AppError?)->()))
}
//
class ArticleVM: ArticleVMProtocol {
    var completionReloadData: (() -> ())?
    lazy var stopLoadMore: Bool = false
    
    lazy var category: String = ""
    lazy var source: NewsSourceModel = NewsSourceModel()
    lazy var articles: [ArticleModel] = []
    lazy var articlesFiltered: [ArticleModel] = []
    
    init(category: String, source: NewsSourceModel) {
        self.category = category
        self.source = source
    }
    
    func getArticle(completion: @escaping((AppError?)->())) {
        var params: [String : String] = [:]
        params["sources"] = source.id
        params["pageSize"] = "\(PageSize)"
        params["page"] = "\((articles.count/PageSize)+1)"
//        print("page", (articles.count/PageSize)+1, "========")
        stopLoadMore = true
        ApiService.instance.makeRequest(url: URLConstant.articleUrl, params: params, model: ArticleResponseModel.self) { error, result in
            self.articles += (result?.articles ?? [])
            self.articlesFiltered = self.articles
//            print((result?.articles ?? []).count, self.articlesFiltered.count, "======")
            self.stopLoadMore = result?.articles.isEmpty ?? false
            completion(error)
        }
    }
    
    func searchArticle(_ text: String) {
        if text == "" || text.isEmpty {
            articlesFiltered = articles
        } else {
            articlesFiltered = articles.filter{
                ($0.title?.localizedCaseInsensitiveContains(text) ?? false) || ($0.source?.name?.localizedCaseInsensitiveContains(text) ?? false) || ($0.author?.localizedCaseInsensitiveContains(text) ?? false)
            }
        }
        completionReloadData?()
    }
    
    func needLoadMore(index: Int) -> Bool {
        guard index > 0 else { return false }
        print(index, stopLoadMore, articlesFiltered.count % index < 5, articlesFiltered.count % index, "=====")
        guard !stopLoadMore else { return false}
        return articlesFiltered.count - 5 < index
    }
}
