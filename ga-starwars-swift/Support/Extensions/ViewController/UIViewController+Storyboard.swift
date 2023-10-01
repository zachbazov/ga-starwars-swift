//
//  UIViewController+Storyboard.swift
//  ga-starwars-swift
//
//  Created by Developer on 01/10/2023.
//

import UIKit

// MARK: - Storyboard

extension UIViewController {
    
    static var xib: UIViewController {
        switch reuseIdentifier {
        case SearchViewController.reuseIdentifier:
            return UIStoryboard(name: reuseIdentifier, bundle: nil).instantiateViewController(withIdentifier: reuseIdentifier)
        default:
            fatalError("Expected view controller type.")
        }
    }
}
