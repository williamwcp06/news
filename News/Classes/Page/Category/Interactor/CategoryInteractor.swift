//
//  CategoryInteractor.swift
//  News
//
//  Created by William on 10/03/23.
//

import Foundation

class CategoryInteractor: CategoryInteractorProtocol {
    weak var presenter: CategoryInteractorOutputProtocol?
    var categoryList: [String] = []
    
    func loadCategory() {
        categoryList = ["business", "entertainment", "general", "health", "science", "sports", "technology"]
        presenter?.fetchCategorySuccess()
    }

}
