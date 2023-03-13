//
//  APIRouter.swift
//  Movinvio
//
//  Created by Ezgi Üstünel on 4.06.2022.
//

import Foundation
import Alamofire

enum APIRouter {
    case movies(id: String, apiKey: String)
    
    private enum Encoding {
        case json
        case string
    }
    
    private var method: HTTPMethod {
        switch self {
        case .movies:
            return .get
        }
    }
    
    private var path: String {
        switch self {
        case .movies:
            return ""
        }
    }
    
    private var encoding: Encoding {
        switch self {
        default:
            return .json
        }
    }
    
    private var queryParameters: [String: Any]? {
        switch self {
        case .movies(let id, let apiKey):
            return ["i": id, "apikey": apiKey]
        }
    }
}

extension APIRouter: URLRequestConvertible {
    func asURLRequest() throws -> URLRequest {
        var endpoint: String = Constants.baseURL.appending(path)
        
        if let queryParameters = queryParameters {
            var isFirstParam: Bool = true
            for queryParameter in queryParameters {
                let queryParameterEncodedKey = queryParameter.key.addingPercentEncoding(withAllowedCharacters: .alphanumerics)
                let queryParameterEncodedValue = (queryParameter.value as AnyObject).addingPercentEncoding(withAllowedCharacters: .alphanumerics)
                if isFirstParam {
                    isFirstParam = false
                    endpoint.append("?\(queryParameterEncodedKey ?? "")=\(queryParameterEncodedValue ?? "")")
                } else {
                    endpoint.append("&\(queryParameterEncodedKey ?? "")=\(queryParameterEncodedValue ?? "")")
                }
            }
        }
        
        var request: URLRequest = URLRequest(url: URL(string: endpoint)!)
        print(request)
        request.httpMethod = method.rawValue
        
        if encoding == .json {
            request.addValue("application/json;charset=utf-8", forHTTPHeaderField: "Content-Type")
        }
        
        return request
    }
}
