//
//  SearchViewModel.swift
//  PokeTeam App
//
//  Created by Gabriel Levis Zawalski on 21/05/22.
//

import Foundation

final class SearchViewModel: ObservableObject {
    private var networkManager: NetworkManagerInput
    @Published var model: SearchModel?
    
    init(networkManager: NetworkManagerInput = NetworkManager()) {
        self.networkManager = networkManager
    }
}

// TODO: Rework feature to work with new SwiftUI views
// MARK: - FILTER
//extension SearchViewModel {
//    internal func filterItems(with string: String) {
//        guard let model = model else { return }
//
//        model.filteredPokemon = string == "" ? model.allPokemon : model.allPokemon.filter { $0.name.contains(string.lowercased()) }
//        model.count = model.filteredPokemon.count
//    }
//}

// MARK: - NETWORKING
extension SearchViewModel {
    func fetchData() async {
        do {
            let list = try await networkManager.fetch(PokemonList.self, url: "https://pokeapi.co/api/v2/pokemon?limit=100000&offset=0")

            await MainActor.run {
                self.model = SearchModel(from: list)
            }
        } catch {
            return
        }
    }
}
