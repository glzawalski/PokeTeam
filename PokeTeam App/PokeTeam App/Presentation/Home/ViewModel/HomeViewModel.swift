//
//  HomeViewModel.swift
//  PokeTeam App
//
//  Created by Gabriel Levis Zawalski on 21/05/22.
//

import Foundation

final class HomeViewModel: ObservableObject {
    private var networkManager: NetworkManagerInput
    @Published var model: HomeModel?
    
    init(networkManager: NetworkManagerInput = NetworkManager()) {
        self.networkManager = networkManager
    }
}

// MARK: - NETWORKING
extension HomeViewModel {
    func fetchData() async {
        do {
            let list = try await networkManager.fetch(PokemonTypeList.self, url: "https://pokeapi.co/api/v2/type")

            await MainActor.run {
                self.model = HomeModel(from: list)
            }
        } catch {
            return
        }
    }
}
