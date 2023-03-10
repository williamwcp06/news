//
//  ArticleDetailProtocol.swift
//  News
//
//  Created by William on 10/03/23.
//

import Foundation
import UIKit

// MARK: View Output (Presenter -> View)
protocol ArticleDetailViewControllerProtocol: class {
    func initUI()
    func loadWebView()
    func showLoading()
    func hideLoading()
}

// MARK: View Input (View -> Presenter)
protocol ArticleDetailPresenterProtocol: class {
    var view: ArticleDetailViewControllerProtocol? { get set }
    var interactor: ArticleDetailInteractorProtocol? { get set }
    var router: ArticleDetailRouterProtocol? { get set }
    
    func viewDidLoad()
    
    func getUrl() -> String
}

// MARK: Interactor Input (Presenter -> Interactor)
protocol ArticleDetailInteractorProtocol: class {
    var article: ArticleModel! { get set }
}

// MARK: Interactor Output (Interactor -> Presenter)
protocol ArticleDetailInteractorOutputProtocol: class {
}


protocol ArticleDetailRouterProtocol: class {
    static func createModule(article: ArticleModel) -> UIViewController
}
