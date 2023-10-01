//
//  URLSessionTask.swift
//  ga-starwars-swift
//
//  Created by Developer on 01/10/2023.
//

import Foundation
import URLDataTransfer

// MARK: - URLSessionTask Type

final class URLSessionTask: URLSessionTaskable {
    
    var task: URLSessionTaskCancellable? {
        willSet {
            task?.cancel()
        }
    }
    
    var isCancelled: Bool = false
}

// MARK: - URLSessionTaskCancellable Implementation

extension URLSessionTask: URLSessionTaskCancellable {
    
    func cancel() {
        task?.cancel()
        
        isCancelled = true
    }
}
