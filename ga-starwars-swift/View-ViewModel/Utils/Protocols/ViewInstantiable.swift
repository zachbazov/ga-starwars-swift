//
//  ViewInstantiable.swift
//  ga-starwars-swift
//
//  Created by Developer on 01/10/2023.
//

import UIKit

// MARK: - ViewInstantiable Type

protocol ViewInstantiable: UIView, Reusable {}

// MARK: - ViewInstantiable Implementation

extension ViewInstantiable {
    
    static var nib: UINib {
        return UINib(nibName: reuseIdentifier, bundle: nil)
    }
    
    func nibDidLoad() {
        let view = Bundle.main.loadNibNamed(String(describing: Self.self), owner: self, options: nil)![0] as! UIView
        
        addSubview(view)
        
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
}
