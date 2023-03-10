//
//  ArticleDetailRouter.swift
//  News
//
//  Created by William on 10/03/23.
//

import Foundation
import UIKit

class ArticleDetailRouter: ArticleDetailRouterProtocol {
    static func createModule(article: ArticleModel) -> UIViewController {
        let viewController = ArticleDetailViewController()
        
        let presenter: ArticleDetailPresenterProtocol & ArticleDetailInteractorOutputProtocol = ArticleDetailPresenter()
        
        viewController.presenter = presenter
        viewController.presenter.router = ArticleDetailRouter()
        viewController.presenter.view = viewController
        viewController.presenter.interactor = ArticleDetailInteractor()
//        viewController.presenter.interactor?.presenter = presenter
        viewController.presenter.interactor?.article = article
        
        return viewController
    }
    
    
}
