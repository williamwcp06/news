//
//  CategoryVM.swift
//  News
//
//  Created by William on 09/03/23.
//

import Foundation

protocol CategoryVMProtocol {
    ///this list cannot be modified/custom value (https://newsapi.org/docs/endpoints/top-headlines)
    var categoryList: [String] { get }
}

class CategoryVM: CategoryVMProtocol {
    lazy var categoryList: [String] = ["business", "entertainment", "general", "health", "science", "sports", "technology"]
    
    
}
