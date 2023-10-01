//
//  SearchRepository.swift
//  ga-starwars-swift
//
//  Created by Developer on 01/10/2023.
//

import Foundation
import URLDataTransfer

// MARK: - SearchRequestable Type

protocol SearchRequestable {
    
    associatedtype EndpointType
    associatedtype RequestType: Decodable
    associatedtype ResponseType: Decodable
    
    func request(endpoint: EndpointType,
                 request: RequestType,
                 cached: ((ResponseType?) -> Void)?,
                 completion: @escaping (Result<ResponseType, DataTransferError>) -> Void) -> URLSessionTaskCancellable?
}

// MARK: - SearchRepository Type

struct SearchRepository: Repository, SearchRequestable {
    var dataTransferService: DataTransferService
}

// MARK: - SearchRequestable Implementation

extension SearchRepository {
    
    func request(endpoint: SearchUseCase.Endpoints,
                 request: HTTPCharacterDTO.Request,
                 cached: ((HTTPCharacterDTO.Response?) -> Void)?,
                 completion: @escaping (Result<HTTPCharacterDTO.Response, DataTransferError>) -> Void) -> URLSessionTaskCancellable? {
        
        let sessionTask = URLSessionTask()
        
        guard !sessionTask.isCancelled else { return nil }
        
        switch endpoint {
        case .fetch:
            
            let endpoint = SearchRepository.fetch(with: request)
            
            sessionTask.task = dataTransferService.request(
                endpoint: endpoint,
                completion: completion)
            
        case .search:
            
            let endpoint = SearchRepository.search(with: request)
            
            sessionTask.task = dataTransferService.request(
                endpoint: endpoint,
                completion: completion)
        }
        
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

