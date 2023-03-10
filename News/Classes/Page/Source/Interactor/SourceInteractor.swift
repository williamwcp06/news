//
//  SourceInteractor.swift
//  News
//
//  Created by William on 10/03/23.
//

import Foundation

class SourceInteractor: SourceInteractorProtocol {
    var presenter: SourceInteractorOutputProtocol?
    var sources: [SourceModel]?
    var sourcesFiltered: [SourceModel]?
    var category: String!
    
    func fetchSource() {
        var params: [String: String] = [:]
        params["category"] = category
        ApiManager.instance.makeRequest(url: URLConstant.sourceUrl, params: params, model: SourceResponseModel.self) { [weak self] error, result in
            guard let self else { return }
            if let error {
                self.presenter?.fetchFailedSource(error: error)
                return
            }
            
            if let sources = result?.sources {
                self.sources = (self.sources ?? []) + sources
                self.sourcesFiltered = self.sources
                self.presenter?.fetchSuccessSource()
            }
        }
    }
    
    func getSourceBySearch(text: String) {
        if text == "" || text.isEmpty {
            self.sourcesFiltered = sources
        } else {
            sourcesFiltered = sources?.filter{
                return $0.id == text || $0.name.localizedCaseInsensitiveContains(text) || $0.country.localizedCaseInsensitiveContains(text)
            }
        }
        self.presenter?.fetchSuccessSource()
    }
    
}
