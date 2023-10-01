//
//  ViewControllerObservable.swift
//  ga-starwars-swift
//
//  Created by Developer on 01/10/2023.
//

import Foundation

// MARK: - ViewControllerObservable Type

protocol ViewControllerObservable {
    func viewDidBindObservers()
    func viewDidUnbindObservers()
}
