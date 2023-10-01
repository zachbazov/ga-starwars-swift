//
//  CollectionViewCell.swift
//  ga-starwars-swift
//
//  Created by Developer on 01/10/2023.
//

import UIKit

// MARK: - CollectionViewCell Type

protocol CollectionViewCell: UICollectionViewCell, ViewInstantiable {
    
    associatedtype ViewModelType
    
    var viewModel: ViewModelType! { get }
    var indexPath: IndexPath! { get }
    
    func updateView(with viewModel: ViewModelType)
}

// MARK: - Create

extension CollectionViewCell {
    
    static func create<T, CVM>(of type: T.Type,
                               on collectionView: UICollectionView,
                               reuseIdentifier: String? = nil,
                               for indexPath: IndexPath,
                               with controllerViewModel: CVM) -> T
    where T: UICollectionViewCell, CVM: CoordinatorViewModel {
        
        collectionView.register(SearchCollectionViewCell.nib, forCellWithReuseIdentifier: SearchCollectionViewCell.reuseIdentifier)
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier ?? String(describing: type), for: indexPath) as? T
        else { fatalError() }
        
        switch (cell, controllerViewModel) {
        case (let cell as SearchCollectionViewCell, let controllerViewModel as SearchViewModel):
            let item = controllerViewModel.characters[indexPath.row]
            
            cell.indexPath = indexPath
            cell.viewModel = SearchCollectionViewCellViewModel(with: item)
            cell.updateView(with: cell.viewModel)
        default:
            fatalError()
        }
        
        return cell
    }
}

// MARK: - Reusable Implementation

extension UICollectionViewCell: Reusable {}
