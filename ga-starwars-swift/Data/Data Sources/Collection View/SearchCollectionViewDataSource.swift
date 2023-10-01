//
//  SearchCollectionViewDataSource.swift
//  ga-starwars-swift
//
//  Created by Developer on 01/10/2023.
//

import UIKit

// MARK: - SearchCollectionViewDataSource Type

final class SearchCollectionViewDataSource: CollectionViewDataSource {
    
    private let viewModel: SearchViewModel
    
    
    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
    }
    
    
    func dataSourceDidChange() {
        guard let collectionView = viewModel.coordinator?.viewController?.collectionView else { return }
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.reloadData()
    }
    
    
    override func numberOfSections() -> Int {
        return 1
    }
    
    override func numberOfItems(in section: Int) -> Int {
        return viewModel.characters.value.count
    }
    
    override func cellForItemAt<T>(in collectionView: UICollectionView, at indexPath: IndexPath) -> T where T : UICollectionViewCell {
        
        let cell = SearchCollectionViewCell
            .create(of: SearchCollectionViewCell.self,
                    on: collectionView,
                    for: indexPath,
                    with: viewModel)
        
        if let favoriteCharacter = viewModel.favoriteCharacter {
            
            let char = viewModel.characters.value[indexPath.row]
            cell.isFavorite = char == favoriteCharacter
        } else {
            cell.isFavorite = false
        }
        
        return cell as! T
    }
    
    override func didSelectItem(in collectionView: UICollectionView, at indexPath: IndexPath) {
        let selectedCharacter = viewModel.characters.value[indexPath.row]
        
        viewModel.favoriteCharacter = selectedCharacter
        
        for case let cell as SearchCollectionViewCell in collectionView.visibleCells where cell.indexPath == indexPath {
            cell.viewModel.isHighlighted = true
        }
        
        collectionView.reloadData()
    }
    
    override func willDisplayCellForItem<T>(_ cell: T, at indexPath: IndexPath) where T : UICollectionViewCell {
//        cell.opacityAnimation()
    }
    
    override func viewForSupplementaryElement(in collectionView: UICollectionView, ofKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        return .init()
    }
    
    // MARK: UIScrollViewDelegate Implementation
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let contentHeight = scrollView.contentSize.height
        let yOffset = scrollView.contentOffset.y
        let screenHeight = scrollView.frame.size.height
        
        let newPage = viewModel.currentPage + 1
        
        if yOffset > .zero &&
            newPage > viewModel.currentPage &&
            yOffset > contentHeight - screenHeight {
            
            viewModel.currentPage += 1
            
            handleFetchRequest()
        }
        
        if yOffset == .zero {
            let newPage = viewModel.currentPage - 1
            
            if viewModel.currentPage == 0 {
                viewModel.currentPage = 1
                return
            } else {
                
                if newPage != .zero {
                    viewModel.currentPage -= 1
                    
                    handleFetchRequest()
                }
            }
        }
        
        if viewModel.currentPage == viewModel.totalPages {
            sortCharactersByHeight()
        }
    }
}

// MARK: - Private Implementation

extension SearchCollectionViewDataSource {
    
    private func handleFetchRequest() {
        if !viewModel.isFetchingData {
            
            let request = HTTPCharacterDTO.Request(page: viewModel.currentPage)
            
            viewModel.fetchCharacters(with: request) { [weak self] response in
                guard let self = self else { return }
                
                let results = response.results.map { $0.toDomain() }
                self.viewModel.currentResults = results
                self.viewModel.characters.value = results
                /// Yes, we could append the results to the `characters` array,
                /// I chose not to due to memory inefficiency.
                
                guard let controller = self.viewModel.coordinator?.viewController else { return }
                controller.dataSource?.dataSourceDidChange()
                
                controller.collectionView.scrollToItem(at: IndexPath(row: .zero, section: .zero), at: .top, animated: true)
            }
        }
    }
    
    private func sortCharactersByHeight() {
        guard let controller = self.viewModel.coordinator?.viewController else { return }
        
        viewModel.characters.value.sort { return $0.height < $1.height }
        
        controller.dataSource?.dataSourceDidChange()
    }
}
