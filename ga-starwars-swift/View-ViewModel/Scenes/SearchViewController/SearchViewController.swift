//
//  SearchViewController.swift
//  ga-starwars-swift
//
//  Created by Developer on 01/10/2023.
//

import UIKit

// MARK: - SearchViewController Type

final class SearchViewController: UIViewController, CoordinatorViewController {
    
    @IBOutlet private(set) weak var collectionView: UICollectionView!
    @IBOutlet private(set) weak var searchBar: UISearchBar!
    
    var controllerViewModel: SearchViewModel?
    
    private(set) var dataSource: SearchCollectionViewDataSource?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewDidConfigure()
        controllerViewModel?.viewDidLoad()
    }
    
    
    func viewDidConfigure() {
        setupCollectionView()
        setupDataSource()
    }
}

// MARK: - Private Implementation

extension SearchViewController {
    
    private func setupCollectionView() {
        let layout = CollectionViewLayout(layout: .search, scrollDirection: .vertical)
        collectionView.setCollectionViewLayout(layout, animated: false)
    }
    
    private func setupDataSource() {
        dataSource = SearchCollectionViewDataSource(viewModel: controllerViewModel!)
        dataSource?.dataSourceDidChange()
    }
}
