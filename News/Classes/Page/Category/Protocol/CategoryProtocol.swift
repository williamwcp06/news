//
//  CategoryContract.swift
//  News
//
//  Created by William on 10/03/23.
//

import UIKit

// MARK: View Output (Presenter -> View)
protocol CategoryViewProtocol: class {
    func reloadData()
    func initUI()
}


// MARK: View Input (View -> Presenter)
protocol CategoryPresenterProtocol: class {
    var view: CategoryViewProtocol? { get set }
    var interactor: CategoryInteractorProtocol? { get set }
    var router: CategoryRouterProtocol? { get set }
    
    func getCategoryList() -> [String]
    func viewDidLoad()
    func didSelectRowAt(index: Int)
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol CategoryInteractorProtocol: class {
    var presenter: CategoryInteractorOutputProtocol? { get set }
    var categoryList: [String] { get set }
    
    func loadCategory()
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol CategoryInteractorOutputProtocol: class {
    func fetchCategorySuccess()
}


protocol CategoryRouterProtocol: class {
    static func createModule() -> UINavigationController
    func pushToSource(on view: CategoryViewProtocol, with category: String)
}

