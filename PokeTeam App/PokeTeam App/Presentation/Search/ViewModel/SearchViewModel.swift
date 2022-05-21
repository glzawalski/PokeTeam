//
//  SearchViewModel.swift
//  PokeTeam App
//
//  Created by Gabriel Levis Zawalski on 21/05/22.
//

import Foundation

protocol SearchViewModelInput {
    var model: SearchModel? { get }
    
    func fetchData()
}

protocol SearchViewModelOutput {
    func didFetchData()
    func didFailFetchData()
}

final class SearchViewModel: SearchViewModelInput {
    
    var output: SearchViewModelOutput
    private var networkManager: NetworkManagerInput
    var model: SearchModel?
    
    init(output: SearchViewModelOutput,
         networkManager: NetworkManagerInput = NetworkManager()) {
        self.output = output
        self.networkManager = networkManager
    }
}

// MARK: - NETWORKING
extension SearchViewModel {
    internal func fetchData() {
        networkManager.fetch(PokemonList.self,
                             url: "https://pokeapi.co/api/v2/pokemon?limit=100000&offset=0") { response in
            switch response {
            case .failure:
                self.output.didFailFetchData()
            case .success(let list):
                self.model = SearchModel(from: list)
                self.output.didFetchData()
            }
        }
    }
}
