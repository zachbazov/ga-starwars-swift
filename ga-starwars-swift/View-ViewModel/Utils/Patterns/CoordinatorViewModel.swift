//
//  CoordinatorViewModel.swift
//  ga-starwars-swift
//
//  Created by Developer on 01/10/2023.
//

import Foundation

// MARK: - CoordinatorViewModel Type

protocol CoordinatorViewModel {
    
    associatedtype CoordinatorType: Coordinator
    
    var coordinator: CoordinatorType? { get }
}
