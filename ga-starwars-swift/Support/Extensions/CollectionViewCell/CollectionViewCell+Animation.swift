//
//  CollectionViewCell+Animation.swift
//  ga-starwars-swift
//
//  Created by Developer on 01/10/2023.
//

import UIKit

// MARK: - Animations

extension UICollectionViewCell {
    func opacityAnimation() {
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.duration = 0.5
        animation.fromValue = 0
        animation.toValue = 1
        layer.add(animation, forKey: "opacity")
    }
}
