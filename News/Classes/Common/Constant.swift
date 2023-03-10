//
//  Constant.swift
//  News
//
//  Created by William on 09/03/23.
//

import UIKit

public let PageSize: Int = 20
public let ApiKey: String = "f20e0733262647bdbe89998b479b10c4"

public struct ScreenSize {
    static let height = UIScreen.main.bounds.height
    static let width = UIScreen.main.bounds.width
    static let navigationBar = ScreenSize.notchPhone ? 90 : 64
    static let notchPhone: Bool = ScreenSize.height / ScreenSize.width > 1.8
}

public struct URLConstant {
    static let articleUrl = "https://newsapi.org/v2/everything"
    static let sourceUrl = "https://newsapi.org/v2/top-headlines/sources"
}

public struct HTTPMethod {
    static let post = "POST"
    static let get  = "GET"
}

