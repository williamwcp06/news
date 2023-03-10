//
//  SourcePresenter.swift
//  News
//
//  Created by William on 10/03/23.
//

import Foundation

class SourcePresenter: SourcePresenterProtocol {
    var view: SourceViewControllerProtocol?
    var interactor: SourceInteractorProtocol?
    var router: SourceRouterProtocol?
    
    
    func viewDidLoad() {
        view?.initUI()
        fetchSource()
    }
    
    func fetchSource() {
        view?.showLoading()
        interactor?.fetchSource()
    }
    
    func getSourcesFiltered() -> [SourceModel]? {
        return interactor?.sourcesFiltered
    }
    
    func getSourceBySearch(text: String) {
        guard let interactor else { return }
        interactor.getSourceBySearch(text: text)
    }
    
    func didSelectRowAt(index: Int) {
        guard let view else { return }
        guard let source = interactor?.sourcesFiltered?[index] else { return }
        router?.pushToArticle(on: view, with: source)
    }
}

extension SourcePresenter: SourceInteractorOutputProtocol {
    func fetchSuccessSource() {
        view?.reloadData()
        view?.hideLoading()
    }
    
    func fetchFailedSource(error: AppError) {
        view?.showError(error: error)
        view?.hideLoading()
    }
    
    
}
