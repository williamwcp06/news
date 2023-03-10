//
//  ArticleProtocol.swift
//  News
//
//  Created by William on 10/03/23.
//

import Foundation
import UIKit

// MARK: View Output (Presenter -> View)
protocol ArticleViewControllerProtocol: class {
    func initUI()
    func showError(error: AppError)
    func reloadData()
    func endEditing()
    func showLoading()
    func hideLoading()
}

// MARK: View Input (View -> Presenter)
protocol ArticlePresenterProtocol: class {
    var view: ArticleViewControllerProtocol? { get set}
    var interactor: ArticleInteractorProtocol? { get set }
    var router: ArticleRouterProtocol? { get set }
    
    func viewDidLoad()
    func fetchArticle()
    func getArticlesFiltered() -> [ArticleModel]?
    func getArticleBySearch(text: String)
    
    func didSelectRowAt(index: Int)
    func needLoadMore(index: Int) -> Bool
    
}

// MARK: Interactor Input (Presenter -> Interactor)
protocol ArticleInteractorProtocol: class {
    var presenter: ArticleInteractorOutputProtocol? { get set }
    var articles: [ArticleModel]? { get set }
    var articlesFiltered: [ArticleModel]? { get set }
    var source: SourceModel! { get set }
    var stopLoadMore: Bool { get set }
    
    func fetchArticle()
    func getArticleBySearch(text: String)
    func needLoadMore(index: Int) -> Bool
}

// MARK: Interactor Output (Interactor -> Presenter)
protocol ArticleInteractorOutputProtocol: class {
    func fetchSuccessArticle()
    func fetchFailedArticle(error: AppError)
}


protocol ArticleRouterProtocol: class {
    static func createModule(source: SourceModel) -> UIViewController
    func pushToArticleDetail(on view: ArticleViewControllerProtocol, with article: ArticleModel)
}
