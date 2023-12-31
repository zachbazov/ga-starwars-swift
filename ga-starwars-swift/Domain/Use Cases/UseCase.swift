//
//  UseCase.swift
//  ga-starwars-swift
//
//  Created by Developer on 01/10/2023.
//

import Foundation
import URLDataTransfer

// MARK: - UseCaseRequestable Type

protocol UseCaseRequestable {
    
    associatedtype EndpointType
    associatedtype RequestType: Decodable
    associatedtype ResponseType: Decodable
    
    func request(endpoint: EndpointType,
                 request: RequestType,
                 completion: @escaping (Result<ResponseType, DataTransferError>) -> Void) -> URLSessionTaskCancellable?
    
    func request(endpoint: EndpointType, request: RequestType) async -> ResponseType?
}

// MARK: - UseCase Type

protocol UseCase: UseCaseRequestable {
    
    associatedtype RepositoryType: Repository
    
    var repository: RepositoryType { get }
}
