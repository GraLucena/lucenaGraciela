//
//  Router.swift
//  lucenaGraciela
//
//  Created by Graciela Lucena on 3/4/17.
//  Copyright © 2017 Graciela Lucena. All rights reserved.
//

import Foundation
import Alamofire

typealias jsonDictionary = [String: AnyObject]

enum Router {
    
    // MARK: - Configuration
    private static let baseHostPath = "https://www.reddit.com"

    var baseURLPath: String {
        return "\(Router.baseHostPath)"
    }
    
    case getTop(String)
    
}

extension Router {
    
    struct Request {
        let method: Alamofire.HTTPMethod
        let path: String
        let encoding: ParameterEncoding?
        let parameters: jsonDictionary?
        
        init(method: Alamofire.HTTPMethod,
             path: String,
             parameters: jsonDictionary? = nil,
             encoding: ParameterEncoding = JSONEncoding.default) {
            
            self.method = method
            self.path = path
            self.encoding = encoding
            self.parameters = parameters
        }
    }
    
    var request: Request {
        switch self {
            
        case .getTop(let nextPage):
            var path = "top/.json"
            
            if nextPage != "" {
                path = "top/.json?count=25&after=\(nextPage)"
            }
            return Request(method: .get, path: path, encoding: URLEncoding.default)
        }
    }
}

// MARK: - URLRequestConvertible

extension Router: URLRequestConvertible {
    
    func asURLRequest() throws -> URLRequest {
        let url = URL(string: baseURLPath)!
        var urlRequest = URLRequest(url: url.appendingPathComponent(request.path))
        urlRequest.httpMethod = request.method.rawValue
        
        if let encoding = request.encoding {
            return try encoding.encode(urlRequest, with: request.parameters)
        } else {
            return urlRequest
        }
    }
}
