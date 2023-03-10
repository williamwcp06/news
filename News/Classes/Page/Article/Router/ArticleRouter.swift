//
//  ArticleRouter.swift
//  News
//
//  Created by William on 10/03/23.
//

import Foundation
import UIKit

class ArticleRouter: ArticleRouterProtocol {
    static func createModule(source: SourceModel) -> UIViewController {
        let viewController = ArticleViewController()
        let presenter: ArticlePresenterProtocol & ArticleInteractorOutputProtocol = ArticlePresenter()
        
        viewController.presenter = presenter
        viewController.presenter?.router = ArticleRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = ArticleInteractor()
        viewController.presenter?.interactor?.presenter = presenter
        viewController.presenter.interactor?.source = source
        
        return viewController
    }
    
    func pushToArticleDetail(on view: ArticleViewControllerProtocol, with article: ArticleModel) {
        let detailController = ArticleDetailRouter.createModule(article: article)
        let controller = view as! ArticleViewController
        controller.navigationController?.pushViewController(detailController, animated: true)
    }
    
    
}
