//
//  APIRounter.swift
//  CurrencyConverterTask
//
//  Created by Justinas Baronas on 8/22/17.
//  Copyright © 2017 Vytautas Gimbutas. All rights reserved.
//

import Foundation
import Alamofire


enum APIRouter: URLRequestConvertible {
    
    static let baseURL = URL(string: "http://api.evp.lt/")!
    
    case sellCurrency(String, String, String)
    
    var method: HTTPMethod {
        switch self {
        case .sellCurrency:
            return .get
        }
    }
    
    var path: String {
        switch self {
            case .sellCurrency(let amount, let from, let to):
            return "currency/commercial/exchange/\(amount)-\(from)/\(to)/latest"
        }
    }
    func asURLRequest() throws  -> URLRequest {
        var urlRequest = URLRequest(url: APIRouter.baseURL.appendingPathComponent(path))
        
        urlRequest.httpMethod = method.rawValue
        
        return urlRequest
    }
}
