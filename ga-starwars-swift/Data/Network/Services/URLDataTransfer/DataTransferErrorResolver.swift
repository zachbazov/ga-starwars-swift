//
//  DataTransferErrorResolver.swift
//  ga-starwars-swift
//
//  Created by Developer on 01/10/2023.
//

import Foundation
import URLDataTransfer

// MARK: - DataTransferErrorResolver Type

public struct DataTransferErrorResolver: DataTransferErrorResolvable {
    
    public func resolve(urlRequestError error: URLRequestError) -> DataTransferError {
        let resolvedError = resolve(error: error)
        
        return resolvedError is URLRequestError ? .requestFailure(error) : .resolvedRequestFailure(resolvedError)
    }
    
    
    private func resolve(error: URLRequestError) -> Error {
        let code = URLError.Code(rawValue: (error as NSError).code)
        
        switch code {
        default:
            return error
        }
    }
}
