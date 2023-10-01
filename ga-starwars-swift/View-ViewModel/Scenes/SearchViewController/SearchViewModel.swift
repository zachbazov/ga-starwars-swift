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
    
    var characters: Observable<[Char]> = Observable([])
    
    var query: Observable<String> = Observable("")
    var currentResults: [Char] = []
    
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
            
            let results = response.results.map { $0.toDomain() }
            self.characters.value = results
            self.currentResults = results
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
    
    func searchCharacters(with request: HTTPCharacterDTO.Request, _ completion: @escaping (HTTPCharacterDTO.Response) -> Void) {
        
        useCase.request(
            endpoint: .search,
            request: request,
            completion: { [weak self] result in
                guard let self = self else { return }
                
                switch result {
                case .success(let response):
                    
                    let results = response.results.map { $0.toDomain() }
                    
                    self.characters.value = results
                    
                    DispatchQueue.main.async {
                        completion(response)
                    }
                    
                case .failure(let error):
                    debugPrint(.error, "\(error)")
                }
            })
    }
}

// MARK: - Searching

extension SearchViewModel {
    
    func updateQuery(_ query: String) {
        guard !query.isEmpty else { return }
        
        removeResults()
        
        self.query.value = query
    }
    
    private func removeResults() {
        characters.value.removeAll()
    }
}
