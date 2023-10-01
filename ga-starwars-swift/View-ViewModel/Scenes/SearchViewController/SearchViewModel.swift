//
//  SearchViewModel.swift
//  ga-starwars-swift
//
//  Created by Developer on 01/10/2023.
//

import Foundation
import CodeBureau

// MARK: - SearchViewModel Type

final class SearchViewModel: CoordinatorViewModel {
    
    var coordinator: SearchCoordinator?
    
    
    let useCase = SearchUseCase()
    
    
    var characters: [Char] = []
    
    var isFetchingData = false
    var currentPage: Int = 1
    var totalPages: Int = .zero
    
    var favoriteCharacter: Char?
    
    
    func viewDidLoad() {
        let request = HTTPCharacterDTO.Request(page: currentPage)
        
        fetchCharacters(with: request) { [weak self] response in
            guard let self = self,
                  let controller = self.coordinator?.viewController
            else { return }
            
            self.characters = response.results.map { $0.toDomain() }
            self.totalPages = response.count
            
            controller.dataSource?.dataSourceDidChange()
        }
    }
}

// MARK: - Networking

extension SearchViewModel {
    
    func fetchCharacters(with request: HTTPCharacterDTO.Request, _ completion: @escaping (HTTPCharacterDTO.Response) -> Void) {
        
        ActivityIndicatorView.present()
        
        isFetchingData = true
        
        useCase.request(
            endpoint: .fetch,
            request: request,
            cached: { _ in },
            completion: { [weak self] result in
                guard let self = self else { return }
                
                switch result {
                case .success(let response):
                    
                    ActivityIndicatorView.remove()
                    
                    self.isFetchingData = false
                    
                    DispatchQueue.main.async {
                        completion(response)
                    }
                case .failure(let error):
                    debugPrint(.error, "\(error)")
                }
            })
    }
}
