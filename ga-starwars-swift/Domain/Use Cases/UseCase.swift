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
                 cached: ((ResponseType?) -> Void)?,
                 completion: @escaping (Result<ResponseType, DataTransferError>) -> Void) -> URLSessionTaskCancellable?
}

// MARK: - UseCase Type

protocol UseCase: UseCaseRequestable {
    
    associatedtype RepositoryType: Repository
    
    var repository: RepositoryType { get }
}
