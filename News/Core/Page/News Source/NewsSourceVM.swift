//
//  NewsSourceVM.swift
//  News
//
//  Created by William on 09/03/23.
//

import Foundation

protocol NewsSourceVMProtocol {
    var completionReloadData: (()->())? { get }
    
    var category: String { get set }
    var sources: [NewsSourceModel] { get set }
    var sourcesFiltered: [NewsSourceModel] { get set }
    
    func getNewsSources(completion: @escaping((AppError?)->()))
}

class NewsSourceVM: NewsSourceVMProtocol {
    var completionReloadData: (() -> ())?
    
    lazy var category: String = ""
    lazy var sources: [NewsSourceModel] = []
    lazy var sourcesFiltered: [NewsSourceModel] = []
    
    init(category: String) {
        self.category = category
    }
    
    func getNewsSources(completion: @escaping((AppError?)->())) {
        var params: [String: String] = [:]
        params["category"] = category
        ApiService.instance.makeRequest(url: URLConstant.sourceUrl, params: params, model: NewsSourceResponseModel.self) { error, result in
            self.sources += (result?.sources ?? [])
            self.sourcesFiltered = result?.sources ?? []
            completion(error)
        }
    }
    
    func searchSources(_ text: String) {
        if text == "" || text.isEmpty {
            sourcesFiltered = sources
        } else {
            sourcesFiltered = sources.filter{
                return $0.id == text || $0.name.localizedCaseInsensitiveContains(text) || $0.country.localizedCaseInsensitiveContains(text)
            }
        }
        completionReloadData?()
    }
}
