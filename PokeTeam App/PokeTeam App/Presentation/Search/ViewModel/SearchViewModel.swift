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
