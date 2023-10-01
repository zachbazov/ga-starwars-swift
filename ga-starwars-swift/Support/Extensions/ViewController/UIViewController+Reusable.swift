//
//  UIViewController+Reusable.swift
//  ga-starwars-swift
//
//  Created by Developer on 01/10/2023.
//

import UIKit

// MARK: - ReuseIdentifier

extension UIViewController: Reusable {
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
}
