//
//  URLService.swift
//  ga-starwars-swift
//
//  Created by Developer on 01/10/2023.
//

import Foundation
import URLDataTransfer

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


extension URLService {
    
    func request(endpoint: Requestable) async -> (Data, URLResponse)? {
        do {
            let urlRequest = try await endpoint.urlRequest(with: configuration)
            
            guard let (data, response) = try await self.request(request: urlRequest) else { return nil }
            
            return (data, response)
        } catch {
            return nil
        }
    }
    
    
    func request(request: URLRequest) async throws -> (Data, URLResponse)? {
        logger.log(request: request)
        
        guard let (data, response) = try? await session.request(request) else { return nil }
        
        self.logger.log(responseData: data, response: response)
        
        return (data, response)
    }
}
