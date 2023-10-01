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
        let page: Int
    }
    
    struct Response: Decodable {
        let count: Int
        let next: String
        var previous: String?
        let results: [CharacterDTO]
    }
}
