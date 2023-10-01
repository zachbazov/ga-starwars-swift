//
//  URLRequestConfiguration.swift
//  ga-starwars-swift
//
//  Created by Developer on 01/10/2023.
//

import Foundation
import URLDataTransfer

// MARK: - URLRequestConfiguration Type

struct URLRequestConfiguration: URLRequestConfigurable {
    let baseURL: URL
    let headers: [String: String] = [:]
    let queryParameters: [String: String] = [:]
}
