//
//  SearchRepository.swift
//  ga-starwars-swift
//
//  Created by Developer on 01/10/2023.
//

import Foundation
import URLDataTransfer

// MARK: - SearchRepository Type

struct SearchRepository: Repository {
    var dataTransferService: DataTransferService
}

// MARK: - RepositoryRequestable Implementation

extension SearchRepository {
    
    func fetch(request: HTTPCharacterDTO.Request,
               completion: @escaping (Result<HTTPCharacterDTO.Response, DataTransferError>) -> Void) -> URLSessionTaskCancellable? {
        
        let sessionTask = URLSessionTask()
        
        guard !sessionTask.isCancelled else { return nil }
        
        let endpoint = SearchRepository.fetch(with: request)
        
        sessionTask.task = dataTransferService.request(
            endpoint: endpoint,
            completion: completion)
        
        return sessionTask
    }
    
    func search(request: HTTPCharacterDTO.Request,
                completion: @escaping (Result<HTTPCharacterDTO.Response, DataTransferError>) -> Void) -> URLSessionTaskCancellable? {
        
        let sessionTask = URLSessionTask()
        
        guard !sessionTask.isCancelled else { return nil }
        
        let endpoint = SearchRepository.search(with: request)
        
        sessionTask.task = dataTransferService.request(
            endpoint: endpoint,
            completion: completion)
        
        return sessionTask
    }
}

// MARK: - Endpoints

extension SearchRepository {
    
    static func fetch(with request: HTTPCharacterDTO.Request) -> Endpoint {
        let page = request.page ?? 1
        let path = "people"
        let queryParams: [String: Any] = ["page": page]
        
        return Endpoint(method: .get, path: path, queryParameters: queryParams)
    }
    
    static func search(with request: HTTPCharacterDTO.Request) -> Endpoint {
        let query = request.query ?? ""
        let path = "people"
        let queryParams: [String: Any] = ["search": query]
        
        return Endpoint(method: .get, path: path, queryParameters: queryParams)
    }
}

