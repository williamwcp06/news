//
//  SourceProtocol.swift
//  News
//
//  Created by William on 10/03/23.
//

import Foundation
import UIKit

// MARK: View Output (Presenter -> View)
protocol SourceViewControllerProtocol: class {
    func initUI()
    func showError(error: AppError)
    func reloadData()
    func endEditing()
    func showLoading()
    func hideLoading()
}

// MARK: View Input (View -> Presenter)
protocol SourcePresenterProtocol: class {
    var view: SourceViewControllerProtocol? { get set}
    var interactor: SourceInteractorProtocol? { get set }
    var router: SourceRouterProtocol? { get set }
    
    func viewDidLoad()
    func getSourcesFiltered() -> [SourceModel]?
    func getSourceBySearch(text: String)
    func fetchSource()
    
    func didSelectRowAt(index: Int)
    
}

// MARK: Interactor Input (Presenter -> Interactor)
protocol SourceInteractorProtocol: class {
    var presenter: SourceInteractorOutputProtocol? { get set }
    var category: String! { get set }
    var sources: [SourceModel]? { get set }
    var sourcesFiltered: [SourceModel]? { get set }
    
    func fetchSource()
    func getSourceBySearch(text: String)
}

// MARK: Interactor Output (Interactor -> Presenter)
protocol SourceInteractorOutputProtocol: class {
    func fetchSuccessSource()
    func fetchFailedSource(error: AppError)
}


protocol SourceRouterProtocol: class {
    static func createModule(category: String) -> UIViewController
    func pushToArticle(on view: SourceViewControllerProtocol, with source: SourceModel)
}
