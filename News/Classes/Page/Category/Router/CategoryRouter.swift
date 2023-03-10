//
//  CategoryRouter.swift
//  News
//
//  Created by William on 10/03/23.
//

import UIKit

class CategoryRouter: CategoryRouterProtocol {
    // MARK: Static methods
    static func createModule() -> UINavigationController {
        let viewController = CategoryViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        
        let presenter: CategoryPresenterProtocol & CategoryInteractorOutputProtocol = CategoryPresenter()
        
        viewController.presenter = presenter
        viewController.presenter?.router = CategoryRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = CategoryInteractor()
        viewController.presenter?.interactor?.presenter = presenter
        
        return navigationController
    }
    
    // MARK: - Navigation
    func pushToSource(on view: CategoryViewProtocol, with category: String) {
        guard let viewController = view as? CategoryViewController else { return }
        
        let sourceViewController = SourceRouter.createModule(category: category)
        
        viewController.navigationController?.pushViewController(sourceViewController, animated: true)
        
    }
    
}
