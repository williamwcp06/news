//
//  SourceRouter.swift
//  News
//
//  Created by William on 10/03/23.
//

import Foundation
import UIKit

class SourceRouter: SourceRouterProtocol {
    static func createModule(category: String) -> UIViewController {
        let viewController = SourceViewController()
        
        let presenter: SourcePresenterProtocol & SourceInteractorOutputProtocol = SourcePresenter()
        
        viewController.presenter = presenter
        viewController.presenter?.router = SourceRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = SourceInteractor()
        viewController.presenter?.interactor?.presenter = presenter
        viewController.presenter.interactor?.category = category
        
        return viewController
    }
    
    func pushToArticle(on view: SourceViewControllerProtocol, with source: SourceModel) {
        let articleViewController = ArticleRouter.createModule(source: source)
        
        guard let viewController = view as? SourceViewController else { return }
        viewController.navigationController?.pushViewController(articleViewController, animated: true)
    }
    
    
}
