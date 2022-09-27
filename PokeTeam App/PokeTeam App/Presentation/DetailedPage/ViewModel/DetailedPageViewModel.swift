//
//  DetailedPageViewModel.swift
//  PokeTeam App
//
//  Created by Gabriel Levis Zawalski on 21/05/22.
//

import Foundation

final class DetailedPageViewModel: ObservableObject {
    private var pokemon: Pokemon
    private var networkManager: NetworkManagerInput
    @Published var model: DetailedPageModel?
    
    init(pokemon: Pokemon, networkManager: NetworkManagerInput = NetworkManager()) {
        self.pokemon = pokemon
        self.networkManager = networkManager
    }
}

// MARK: - NETWORKING
extension DetailedPageViewModel {
    func fetchData() async {
        do {
            let details = try await networkManager.fetch(PokemonDetails.self, url: pokemon.url)

            await MainActor.run {
                self.model = DetailedPageModel(from: details)
            }
        } catch {
            return
        }
    }
}
