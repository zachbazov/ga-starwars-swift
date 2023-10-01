//
//  SearchCollectionViewCell.swift
//  ga-starwars-swift
//
//  Created by Developer on 01/10/2023.
//

import UIKit

// MARK: - SearchCollectionViewCell Type

final class SearchCollectionViewCell: UICollectionViewCell, CollectionViewCell {
    
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var heightLabel: UILabel!
    @IBOutlet private weak var heightContainer: UIView!
    
    
    var viewModel: SearchCollectionViewCellViewModel!
    
    var indexPath: IndexPath!
    
    
    var isFavorite: Bool = false {
        didSet {
            if isFavorite {
                contentView.backgroundColor = .link
            } else {
                contentView.backgroundColor = .white
            }
        }
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        nameLabel.text = ""
        heightLabel.text = ""
        viewModel = nil
        indexPath = nil
    }
    
    
    func updateView(with viewModel: SearchCollectionViewCellViewModel) {
        nameLabel.text = viewModel.name
        heightLabel.text = viewModel.height
        
        heightContainer.layer.borderColor = UIColor.darkGray.cgColor
        heightContainer.layer.borderWidth = 1.5
        heightContainer.layer.cornerRadius = 4.0
    }
}
