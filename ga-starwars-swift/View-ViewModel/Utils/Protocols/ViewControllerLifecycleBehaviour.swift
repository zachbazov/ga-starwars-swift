//
//  ViewControllerLifecycleBehaviour.swift
//  ga-starwars-swift
//
//  Created by Developer on 01/10/2023.
//

import Foundation

// MARK: - ViewControllerLifecycleBehaviour Type

protocol ViewControllerLifecycleBehaviour {
    func viewDidDeploySubviews()
    func viewDidConfigure()
    func viewDidDeallocate()
}
