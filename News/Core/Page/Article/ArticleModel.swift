//
//  NewsModel.swift
//  News
//
//  Created by William on 09/03/23.
//

import Foundation

struct ArticleResponseModel: Codable {
    var articles: [ArticleModel] = []
}

struct ArticleModel: Codable {
    var source: SourceModel?
    var author: String?
    var title: String?
    var description: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: String?
    var content: String?
}

struct SourceModel: Codable {
    var id: String?
    var name: String?
}
