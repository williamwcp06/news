//
//  SourceModel.swift
//  News
//
//  Created by William on 09/03/23.
//

import Foundation

struct SourceResponseModel: Codable {
    var sources: [SourceModel] = []
}

struct SourceModel: Codable {
    var id: String = ""
    var name: String = ""
    var description: String = ""
    var url: String = ""
    var category: String = ""
    var language: String = ""
    var country: String = ""
}
