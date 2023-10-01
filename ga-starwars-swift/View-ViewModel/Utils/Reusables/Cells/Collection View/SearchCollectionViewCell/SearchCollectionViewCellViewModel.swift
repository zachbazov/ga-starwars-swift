//
//  SearchCollectionViewCellViewModel.swift
//  ga-starwars-swift
//
//  Created by Developer on 01/10/2023.
//

import Foundation

// MARK: - SearchCollectionViewCellViewModel Type

struct SearchCollectionViewCellViewModel: ViewModel {
    
    let name: String
    let height: String
    var isHighlighted: Bool
    
    init(with model: Char) {
        self.name = model.name
        self.height = model.height
        self.isHighlighted = model.isHighlighted
    }
}
