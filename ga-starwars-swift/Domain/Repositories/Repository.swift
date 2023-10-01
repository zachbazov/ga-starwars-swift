//
//  Repository.swift
//  ga-starwars-swift
//
//  Created by Developer on 01/10/2023.
//

import Foundation
import URLDataTransfer

// MARK: - RepositoryRequestable Type

protocol RepositoryRequestable {
    
    associatedtype EndpointType
    associatedtype ResponseType: Decodable
    
    func find(request: Any?,
              cached: ((ResponseType?) -> Void)?,
              completion: @escaping (Result<ResponseType, DataTransferError>) -> Void) -> URLSessionTaskCancellable?
}

// MARK: - Repository Type

protocol Repository: RepositoryRequestable {}

// MARK: - RepositoryRequestable Implementation

extension Repository {
    
    func find(request: Any?,
              cached: ((ResponseType?) -> Void)?,
              completion: @escaping (Result<ResponseType, DataTransferError>) -> Void) -> URLSessionTaskCancellable? {
        return nil
    }
}
