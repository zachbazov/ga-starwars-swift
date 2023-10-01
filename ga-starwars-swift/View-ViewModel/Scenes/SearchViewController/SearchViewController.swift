//
//  SearchViewController.swift
//  ga-starwars-swift
//
//  Created by Developer on 01/10/2023.
//

import UIKit
import CodeBureau

// MARK: - SearchViewController Type

final class SearchViewController: UIViewController, CoordinatorViewController {
    
    @IBOutlet private(set) weak var collectionView: UICollectionView!
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var contentContainer: UIView!
    
    var controllerViewModel: SearchViewModel?
    
    private(set) var dataSource: SearchCollectionViewDataSource?
    
    private var searchController = UISearchController(searchResultsController: nil)
    
    
    deinit {
        viewDidDeallocate()
    }
    
    // MARK: UIViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewDidDeploySubviews()
        viewDidConfigure()
        viewDidBindObservers()
        controllerViewModel?.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        searchController.isActive = false
    }
    
    // MARK: ViewControllerLifecycleBehaviour
    
    func viewDidDeploySubviews() {
        setupCollectionView()
        setupDataSource()
    }
    
    func viewDidConfigure() {
        configureSearchController()
        configureSearchBar()
    }
    
    func viewDidBindObservers() {
        controllerViewModel?.characters.observe(on: self) { [weak self] in
            guard !$0.isEmpty else { return }
            
            self?.dataSource?.dataSourceDidChange()
        }
        
        controllerViewModel?.query.observe(on: self) { [weak self] in
            self?.updateSearchBarQuery($0)
        }
    }
    
    func viewDidUnbindObservers() {
        guard let controllerViewModel = controllerViewModel else { return }
        
        controllerViewModel.characters.remove(observer: self)
        controllerViewModel.query.remove(observer: self)
        
        debugPrint(.success, "Removed `\(Self.self)` observers.")
    }
    
    func viewDidDeallocate() {
        viewDidUnbindObservers()
        
        searchBar.searchTextField.resignFirstResponder()
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

// MARK: - Searchable Implementation

extension SearchViewController: Searchable {
    
    func updateSearchBarQuery(_ query: String) {
        searchController.searchBar.text = query
    }
}

// MARK: - UISearchBarDelegate Implementation

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text,
              !text.isEmpty
        else { return }
        
        controllerViewModel?.updateQuery(text)
        
        searchBar.searchTextField.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        
        let currentResults = controllerViewModel?.currentResults ?? []
        controllerViewModel?.characters.value = currentResults
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard searchText.count == .zero else { return }
        
        searchBarCancelButtonClicked(searchBar)
    }
}

// MARK: - UISearchResultsUpdating Implementation

extension SearchViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let searchText = searchController.searchBar.searchTextField.text,
              !searchText.isEmpty
        else { return }
        
        ActivityIndicatorView.present()
        
        let request = HTTPCharacterDTO.Request(query: searchText)
        
        if #available(iOS 13.0, *) {
            Task {
                await controllerViewModel?.searchCharacters(with: request)
            }
        } else {
            controllerViewModel?.searchCharacters(with: request) { [weak self] response in
                guard let self = self else { return }
                
                ActivityIndicatorView.remove()
                
                DispatchQueue.main.async {
                    self.dataSource?.dataSourceDidChange()
                }
            }
        }
    }
}

// MARK: - Private Implementation

extension SearchViewController {
    private func configureSearchController() {
        definesPresentationContext = true
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = true
        searchController.hidesNavigationBarDuringPresentation = false
    }
    
    private func configureSearchBar() {
        searchBar.delegate = self
    }
}
