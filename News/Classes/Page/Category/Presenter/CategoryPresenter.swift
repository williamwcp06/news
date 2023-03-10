//
//  CategoryPresenter.swift
//  News
//
//  Created by William on 10/03/23.
//

import Foundation

class CategoryPresenter: CategoryPresenterProtocol {
    weak var view: CategoryViewProtocol?
    var interactor: CategoryInteractorProtocol?
    var router: CategoryRouterProtocol?
    
    func viewDidLoad() {
        view?.initUI()
        interactor?.loadCategory()
    }
    
    func getCategoryList() -> [String] {
        return interactor?.categoryList ?? []
    }
    
    func didSelectRowAt(index: Int) {
        guard let view else { return }
        let category = getCategoryList()[index]
        router?.pushToSource(on: view, with: category)
    }
}

extension CategoryPresenter: CategoryInteractorOutputProtocol {
    func fetchCategorySuccess() {
        view?.reloadData()
    }
    
}
