//
//  Application.swift
//  ga-starwars-swift
//
//  Created by Developer on 01/10/2023.
//

import UIKit

// MARK: - Application Type

final class Application {
    
    static var app = Application()
    
    private init() {}
    
    
    let coordinator = AppCoordinator()
    
    var dataTransferService: DataTransferService {
        guard let url = URL(string: "https://swapi.dev/api/") else { fatalError() }
        
        let requestConfiguration = URLRequestConfiguration(baseURL: url)
        let urlService = URLService(configuration: requestConfiguration)
        
        return DataTransferService(urlService: urlService)
    }
    
    
    
    func appDidLaunch(in window: UIWindow?) {
        coordinator.window = window
    }
}
