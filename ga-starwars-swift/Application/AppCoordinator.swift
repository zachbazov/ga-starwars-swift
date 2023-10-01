//
//  AppCoordinator.swift
//  ga-starwars-swift
//
//  Created by Developer on 01/10/2023.
//

import UIKit

// MARK: - AppCoordinator Type

final class AppCoordinator {
    
    weak var window: UIWindow? {
        didSet {
            coordinate(to: searchCoordinator.viewController)
        }
    }
    
    lazy var searchCoordinator: SearchCoordinator = createSearchCoordinator()
    
    
    func coordinate(to viewController: UIViewController?) {
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
    }
}

// MARK: - Private Implementation

extension AppCoordinator {
    
    private func createSearchCoordinator() -> SearchCoordinator {
        let coordinator = SearchCoordinator()
        let viewModel = SearchViewModel()
        let controller = SearchViewController.xib as! SearchViewController
        
        controller.controllerViewModel = viewModel
        controller.controllerViewModel?.coordinator = coordinator
        coordinator.viewController = controller
        
        return coordinator
    }
}
