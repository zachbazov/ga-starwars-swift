//
//  Endpoint.swift
//  ga-starwars-swift
//
//  Created by Developer on 01/10/2023.
//

import Foundation
import CodeBureau
import URLDataTransfer

// MARK: - Endpoint Type

struct Endpoint: ResponseRequestable {
    
    var method: HTTPMethod
    var path: String
    var isFullPath: Bool = false
    var headerParameters: [String : String] = .jsonContentType
    var queryParametersEncodable: Encodable?
    var queryParameters: [String : Any] = [:]
    var bodyParametersEncodable: Encodable?
    var bodyParameters: [String : Any] = [:]
    var bodyEncoding: BodyEndcoding = .jsonSerializationData
    
    var responseDecoder: ResponseDecodable?
}
