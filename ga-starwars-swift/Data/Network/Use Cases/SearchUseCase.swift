//
//  SearchUseCase.swift
//  ga-starwars-swift
//
//  Created by Developer on 01/10/2023.
//

import Foundation
import URLDataTransfer

// MARK: - SearchUseCase Type

struct SearchUseCase: UseCase {
    
    let repository: SearchRepository
    
    init() {
        let dataTransferService = Application.app.dataTransferService
        self.repository = SearchRepository(dataTransferService: dataTransferService)
    }
}

// MARK: - Endpoints Type

extension SearchUseCase {
    
    enum Endpoints {
        case fetch
        case search
    }
}

// MARK: - UseCase Implementation

extension SearchUseCase {
    
    @discardableResult
    func request(endpoint: Endpoints,
                 request: HTTPCharacterDTO.Request,
                 completion: @escaping (Result<HTTPCharacterDTO.Response, DataTransferError>) -> Void) -> URLSessionTaskCancellable? {
        
        switch endpoint {
        case .fetch:
            return repository.fetch(request: request, completion: completion)
        case .search:
            return repository.search(request: request, completion: completion)
        }
    }
    
    
    func request(endpoint: Endpoints,
                 request: HTTPCharacterDTO.Request) async -> HTTPCharacterDTO.Response? {
        switch endpoint {
        case .fetch:
            return await repository.fetch(request: request)
        case .search:
            return await repository.search(request: request)
        }
    }
}
