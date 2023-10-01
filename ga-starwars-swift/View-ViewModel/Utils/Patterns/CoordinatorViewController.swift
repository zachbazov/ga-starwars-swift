//
//  CoordinatorViewController.swift
//  ga-starwars-swift
//
//  Created by Developer on 01/10/2023.
//

import Foundation

// MARK: - CoordinatorViewController Type

protocol CoordinatorViewController {
    
    associatedtype ViewModelType: CoordinatorViewModel
    
    var controllerViewModel: ViewModelType? { get }
}
