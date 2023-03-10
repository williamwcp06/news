//
//  ApiManager.swift
//  News
//
//  Created by William on 09/03/23.
//

import Foundation

class ApiManager {
    static let instance = ApiManager()
    
    typealias ServiceResponse<T:Decodable> = ((AppError?, T?) -> Void)
    
    func makeRequest<T:Decodable>(url: String, params: [String:String] = [:], model: T.Type, timeout:Double = 60, completion: @escaping ServiceResponse<T>) {
        
        var request = URLRequest(url: getUrl(url: url, queries: params))
            request.httpMethod      = HTTPMethod.get
            request.timeoutInterval = timeout
        
        let configuration = URLSessionConfiguration.ephemeral
        let session = URLSession(configuration: configuration, delegate: nil, delegateQueue: nil)
        let task = session.dataTask(with: request) { (data, response, error) in
            
            if let d = data, let response = String(data: d, encoding: .utf8) {
//                print("response : " + respornse)
            }
            guard error == nil else {
                completion(AppError.commonError(errorCode: -1, errorMessage: error?.localizedDescription ?? ""), nil)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(AppError.commonError(errorCode: 0, errorMessage: "Error Connection"), nil)
                return
            }
            
            guard let data = data else {
                completion(AppError.commonError(errorCode: 0, errorMessage: "Data Error"), nil)
                return
            }
            
            guard  httpResponse.statusCode == 200  else {
                completion(AppError.commonError(errorCode: httpResponse.statusCode, errorMessage: "Error Connection"), nil)
                return
            }
            
            guard let responseModel = try? JSONDecoder().decode(T.self, from: data) else {
                completion(AppError.commonError(errorCode: -2, errorMessage: "Error Convert Data"), nil)
                return
            }
            
            completion(nil, responseModel)
        }
        task.resume()
    }
    
    private func getUrl(url: String, queries: [String: String]) -> URL {
        var _queries = queries
        _queries["apiKey"] = ApiKey
//        guard !queries.isEmpty else {
//            return URL(string: url)!
//        }
        var components         = URLComponents(string: url)
        components?.queryItems = []
        
        for (header, value) in _queries {
            let query = URLQueryItem(name: header, value: value)
            components?.queryItems?.append(query)
        }
//        print(components?.url?.absoluteURL)
        return (components?.url!)!
    }
}

public enum AppError {
    case commonError(errorCode: Int, errorMessage: String)
}

extension AppError: LocalizedError {
    public var errorCode: Int {
        switch self {
        case let .commonError(errorCode, _):
            return errorCode
        }
    }
    
    public var errorDescription: String? {
        switch self {
        case let .commonError(_, errorMessage):
            return errorMessage
        }
    }
}

