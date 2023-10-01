//
//  URLRequestErrorResolver.swift
//  ga-starwars-swift
//
//  Created by Developer on 01/10/2023.
//

import Foundation
import URLDataTransfer

// MARK: - URLRequestErrorResolver Type

struct URLRequestErrorResolver: URLRequestErrorResolvable {
    
    func resolve(requestError: Error, response: URLResponse?, with data: Data?) -> URLRequestError {
        var urlRequestError: URLRequestError
        
        if let response = response as? HTTPURLResponse {
            urlRequestError = .error(statusCode: response.statusCode, data: data)
        } else {
            urlRequestError = resolve(error: requestError)
        }
        
        return urlRequestError
    }
    
    func resolve(error: Error) -> URLRequestError {
        let code = URLError.Code(rawValue: (error as NSError).code)
        
        switch code {
        case .notConnectedToInternet:
            return .noInternetConnection
        case .cannotConnectToHost:
            return .noServerConnection
        case .cancelled:
            return .cancelled
        default:
            return .generic(error)
        }
    }
}
