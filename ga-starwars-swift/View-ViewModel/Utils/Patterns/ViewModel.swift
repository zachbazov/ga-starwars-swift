//
//  ViewModel.swift
//  ga-starwars-swift
//
//  Created by Developer on 01/10/2023.
//

import Foundation

// MARK: - ViewModel Type

protocol ViewModel {
    
    associatedtype ModelType
    
    
    init(with model: ModelType)
}
