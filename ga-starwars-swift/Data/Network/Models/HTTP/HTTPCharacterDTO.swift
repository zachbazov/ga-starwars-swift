//
//  HTTPCharacterDTO.swift
//  ga-starwars-swift
//
//  Created by Developer on 01/10/2023.
//

import Foundation

// MARK: - HTTPCharacterDTO Type

struct HTTPCharacterDTO {
    
    struct Request: Decodable {
        var page: Int?
        var query: String?
    }
    
    struct Response: Decodable {
        let count: Int
        var next: String?
        var previous: String?
        let results: [CharacterDTO]
    }
}
