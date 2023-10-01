//
//  URLService.swift
//  ga-starwars-swift
//
//  Created by Developer on 01/10/2023.
//

import Foundation
import URLDataTransfer

// MARK: - URLRequestable Type

protocol URLRequestable {
    
    associatedtype RequestErrorType: Error
    
    func request(endpoint: Requestable,
                 completion: @escaping (Result<Data?, RequestErrorType>) -> Void) -> URLSessionTaskCancellable?
    
    func request(request: URLRequest,
                 completion: @escaping (Result<Data?, RequestErrorType>) -> Void) -> URLSessionTaskCancellable
}

// MARK: - URLService Type

struct URLService {
    
    let configuration: URLRequestConfigurable
    let session = URLSession.shared
    let urlErrorResolver = URLRequestErrorResolver()
    let logger = URLRequestLogger()
}

// MARK: - URLRequestable Implementation

extension URLService: URLRequestable {
    
    func request(request: URLRequest, completion: @escaping (Result<Data?, URLRequestError>) -> Void) -> URLSessionTaskCancellable {
        
        let dataTask = session.request(request: request) { data, response, requestError in
            
            if let requestError = requestError {
                
                let urlRequestError = urlErrorResolver.resolve(requestError: requestError, response: response, with: data)
                
                logger.log(error: urlRequestError)
                
                return completion(.failure(urlRequestError))
            }
            
            logger.log(responseData: data, response: response)
            
            completion(.success(data))
        }
        
        logger.log(request: request)
        
        return dataTask
    }
    
    func request(endpoint: Requestable, completion: @escaping (Result<Data?, URLRequestError>) -> Void) -> URLSessionTaskCancellable? {
        
        do {
            let urlRequest: URLRequest = try endpoint.urlRequest(with: configuration)
            
            return request(request: urlRequest, completion: completion)
        } catch {
            completion(.failure(.urlGeneration))
            
            return nil
        }
    }
}
