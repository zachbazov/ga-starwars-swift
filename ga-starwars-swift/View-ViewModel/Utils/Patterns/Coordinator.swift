//
//  Coordinator.swift
//  ga-starwars-swift
//
//  Created by Developer on 01/10/2023.
//

import Foundation

// MARK: - Coordinator Type

protocol Coordinator {
    
    associatedtype ViewControllerType: CoordinatorViewController
    
    var viewController: ViewControllerType? { get }
}
