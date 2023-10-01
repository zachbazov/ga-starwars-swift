//
//  CollectionViewDataSource.swift
//  ga-starwars-swift
//
//  Created by Developer on 01/10/2023.
//

import UIKit

// MARK: - DataSource Type

private protocol DataSource {
    func numberOfSections() -> Int
    func numberOfItems(in section: Int) -> Int
    func cellForItemAt<T>(in collectionView: UICollectionView, at indexPath: IndexPath) -> T where T: UICollectionViewCell
    func didSelectItem(in collectionView: UICollectionView, at indexPath: IndexPath)
    func willDisplayCellForItem<T>(_ cell: T, at indexPath: IndexPath) where T: UICollectionViewCell
    func viewForSupplementaryElement(in collectionView: UICollectionView, ofKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView
}

// MARK: - CollectionViewDataSource Type

class CollectionViewDataSource: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, DataSource {
    
    // MARK: UICollectionViewDelegate & UICollectionViewDataSource Implementation
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return numberOfSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfItems(in: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return cellForItemAt(in: collectionView, at: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectItem(in: collectionView, at: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        willDisplayCellForItem(cell, at: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        return viewForSupplementaryElement(in: collectionView, ofKind: kind, at: indexPath)
    }
    
    
    // MARK: DataSource Implementation
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfItems(in section: Int) -> Int {
        return .zero
    }
    
    func cellForItemAt<T>(in collectionView: UICollectionView, at indexPath: IndexPath) -> T where T : UICollectionViewCell {
        return T()
    }
    
    func didSelectItem(in collectionView: UICollectionView, at indexPath: IndexPath) {}
    
    func willDisplayCellForItem<T>(_ cell: T, at indexPath: IndexPath) where T : UICollectionViewCell {}
    
    func viewForSupplementaryElement(in collectionView: UICollectionView, ofKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        return UICollectionReusableView()
    }
}
