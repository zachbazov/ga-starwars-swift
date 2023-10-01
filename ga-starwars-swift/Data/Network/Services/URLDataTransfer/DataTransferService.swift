//
//  DataTransferService.swift
//  ga-starwars-swift
//
//  Created by Developer on 01/10/2023.
//

import Foundation
import URLDataTransfer

// MARK: - DataTransferRequestable Type

protocol DataTransferRequestable {
    
    func request<T, E>(endpoint: E,
                       completion: @escaping (Result<T, DataTransferError>) -> Void) -> URLSessionTaskCancellable?
    where T: Decodable,
          E: ResponseRequestable
    
    func request<E>(endpoint: E,
                    completion: @escaping (Result<Void, DataTransferError>) -> Void) -> URLSessionTaskCancellable?
    where E: ResponseRequestable
}

// MARK: - DataTransferService Type

struct DataTransferService {
    
    let urlService: URLService
    let resolver = DataTransferErrorResolver()
    let logger = DataTransferErrorLogger()
    let decoder = URLResponseDecoder()
}

// MARK: - DataTransferRequestable Implementation

extension DataTransferService: DataTransferRequestable {
    
    func request<T, E>(endpoint: E,
                       completion: @escaping (Result<T, DataTransferError>) -> Void) -> URLSessionTaskCancellable?
    where T: Decodable, E: ResponseRequestable {
        
        return urlService.request(
            endpoint: endpoint,
            completion: { result in
                switch result {
                case .success(let data):
                    
                    let result: Result<T, DataTransferError> = decode(data: data, decoder: decoder)
                    
                    return completion(result)
                    
                case .failure(let error):
                    logger.log(error: error)
                    
                    let error = resolver.resolve(urlRequestError: error)
                    
                    return completion(.failure(error))
                }
            })
    }
    
    func request<E>(endpoint: E,
                    completion: @escaping (Result<Void, DataTransferError>) -> Void) -> URLSessionTaskCancellable?
    where E: ResponseRequestable {
        
        return urlService.request(
            endpoint: endpoint,
            completion: { result in
                switch result {
                case .success:
                    
                    return completion(.success(()))
                    
                case .failure(let error):
                    logger.log(error: error)
                    
                    let resolvedError = resolver.resolve(urlRequestError: error)
                    
                    return completion(.failure(resolvedError))
                }
            })
    }
}

// MARK: - Private Implementation

extension DataTransferService {
    
    private func decode<T>(data: Data?, decoder: URLResponseDecoder) -> Result<T, DataTransferError> where T: Decodable {
        do {
            guard let data = data else { return .failure(.noResponse) }
            
            let response: T = try decoder.json.decode(data)
            
            return .success(response)
        } catch {
            logger.log(error: error)
            
            return .failure(.parsing(error))
        }
    }
}
