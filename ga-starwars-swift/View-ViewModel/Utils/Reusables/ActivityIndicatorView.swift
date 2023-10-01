//
//  ActivityIndicatorView.swift
//  ga-starwars-swift
//
//  Created by Developer on 01/10/2023.
//

import UIKit

// MARK: - ActivityIndicatorView Type

final class ActivityIndicatorView {
    static var indicator: UIActivityIndicatorView?
}

// MARK: - IndicatorProtocol Implementation

extension ActivityIndicatorView {
    
    static func present() {
        DispatchQueue.main.async {
            NotificationCenter.default.addObserver(self,
                                                   selector: #selector(viewDidUpdate),
                                                   name: UIDevice.orientationDidChangeNotification,
                                                   object: nil)
            if indicator == nil,
               let window = Application.app.coordinator.window {
                let frame = UIScreen.main.bounds
                let spinner = UIActivityIndicatorView(frame: frame)
                spinner.backgroundColor = UIColor.black.withAlphaComponent(0.25)
                spinner.style = UIActivityIndicatorView.Style.large
                window.addSubview(spinner)

                spinner.startAnimating()
                self.indicator = spinner
            }
        }
    }

    static func remove() {
        DispatchQueue.main.async {
            guard let spinner = indicator else { return }
            spinner.stopAnimating()
            spinner.removeFromSuperview()
            self.indicator = nil
        }
    }

    @objc
    static func viewDidUpdate() {
        DispatchQueue.main.async {
            if indicator != nil {
                remove()
                present()
            }
        }
    }
}

