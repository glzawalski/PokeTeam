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
    internal func fetchData() {
        networkManager.fetch(PokemonTypeList.self, url: "https://pokeapi.co/api/v2/type") { response in
            switch response {
            case let .success(list): self.model = HomeModel(from: list)
            case .failure: break
            }
        }
    }
}
