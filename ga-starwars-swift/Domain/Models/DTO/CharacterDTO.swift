//
//  CharacterDTO.swift
//  ga-starwars-swift
//
//  Created by Developer on 01/10/2023.
//

import Foundation

// MARK: - CharacterDTO Type

struct CharacterDTO: Decodable {
    let name: String
    let height: String
}

// MARK: - Mapping

extension CharacterDTO {
    func toDomain() -> Char {
        return Char(name: name, height: height, isHighlighted: false)
    }
}
