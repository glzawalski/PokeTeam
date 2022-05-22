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
    func filterItems(with string: String)
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

// MARK: - FILTER
extension SearchViewModel {
    
    internal func filterItems(with string: String) {
        guard let model = model else { return }
        
        model.filteredPokemon = string == "" ? model.allPokemon : model.allPokemon.filter { $0.name.contains(string.lowercased()) }
        model.count = model.filteredPokemon.count
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
