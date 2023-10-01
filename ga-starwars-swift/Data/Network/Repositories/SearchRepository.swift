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
        
        switch endpoint {
        case .fetch:
            let sessionTask = URLSessionTask()
            
            guard !sessionTask.isCancelled else { return nil }
            
            let endpoint = SearchRepository.fetch(with: request)
            
            sessionTask.task = dataTransferService.request(
                endpoint: endpoint,
                completion: completion)
            
            return sessionTask
        }
    }
}

// MARK: - Endpoints

extension SearchRepository {
    
    static func fetch(with request: HTTPCharacterDTO.Request) -> Endpoint {
        let page = request.page
        let path = "people"
        let queryParams: [String: Any] = ["page": page]
        
        return Endpoint(method: .get, path: path, queryParameters: queryParams)
    }
}
