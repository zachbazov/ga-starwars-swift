//
//  CollectionViewLayout.swift
//  ga-starwars-swift
//
//  Created by Developer on 01/10/2023.
//

import UIKit

// MARK: - Layoutable Type

private protocol Layoutable {
    var layout: CollectionViewLayout.Layout! { get }
    var itemsPerLine: CGFloat { get }
    var lineSpacing: CGFloat { get }
    var width: CGFloat { get }
    var height: CGFloat { get }
}

// MARK: - CollectionViewLayout Type

final class CollectionViewLayout: UICollectionViewFlowLayout, Layoutable {
    
    fileprivate var layout: Layout!
    fileprivate var itemsPerLine: CGFloat = 3.0
    fileprivate var lineSpacing: CGFloat = 2.0
    
    fileprivate var width: CGFloat {
        get {
            guard let width = super.collectionView!.bounds.width as CGFloat? else { return .zero }
            switch layout {
            default: return width
            }
        }
        set {}
    }
    
    fileprivate var height: CGFloat {
        get {
            switch layout {
            case .search: return 80.0
            default: return .zero
            }
        }
        set {}
    }
    
    convenience init(layout: Layout, scrollDirection: UICollectionView.ScrollDirection? = .horizontal) {
        self.init()
        self.layout = layout
        self.scrollDirection = scrollDirection == .horizontal ? .horizontal : .vertical
    }
    
    // MARK: UICollectionViewFlowLayout Lifecycle
    
    override func prepare() {
        super.prepare()
        
        minimumLineSpacing = lineSpacing
        minimumInteritemSpacing = .zero
        sectionInset = .zero
        itemSize = CGSize(width: width, height: height)
        
        switch layout {
        case .search:
            sectionInset = .init(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        default: break
        }
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        if let oldBounds = collectionView!.bounds as CGRect?,
           oldBounds.size != newBounds.size {
            return true
        }
        return super.shouldInvalidateLayout(forBoundsChange: newBounds)
    }
}

// MARK: - Layout Type

extension CollectionViewLayout {
    /// Layout representation type.
    enum Layout {
        case search
    }
}
