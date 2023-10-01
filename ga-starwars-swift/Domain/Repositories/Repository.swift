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
    
    associatedtype RequestType: Decodable
    associatedtype ResponseType: Decodable
    
    func fetch(request: RequestType,
               completion: @escaping (Result<ResponseType, DataTransferError>) -> Void) -> URLSessionTaskCancellable?
    
    func search(request: RequestType,
                completion: @escaping (Result<ResponseType, DataTransferError>) -> Void) -> URLSessionTaskCancellable?
    
    
    func fetch(request: RequestType) async -> ResponseType?
    func search(request: RequestType) async -> ResponseType?
}

// MARK: - Repository Type

protocol Repository: RepositoryRequestable {}
