//
//  HomeViewModel.swift
//  PokeTeam App
//
//  Created by Gabriel Levis Zawalski on 21/05/22.
//

import Foundation

protocol HomeViewModelInput {
    var model: HomeModel? { get }
    
    func fetchData()
}

protocol HomeViewModelOutput {
    func didFetchData()
    func didFailFetchData()
}

final class HomeViewModel: HomeViewModelInput {
    
    var output: HomeViewModelOutput
    private var networkManager: NetworkManagerInput
    var model: HomeModel?
    
    init(output: HomeViewModelOutput,
         networkManager: NetworkManagerInput = NetworkManager()) {
        self.output = output
        self.networkManager = networkManager
    }
}

// MARK: - NETWORKING
extension HomeViewModel {
    internal func fetchData() {
        networkManager.fetch(PokemonTypeList.self,
                             url: "https://pokeapi.co/api/v2/type") { response in
            switch response {
            case .failure:
                self.output.didFailFetchData()
            case .success(let list):
                self.model = HomeModel(from: list)
                self.output.didFetchData()
            }
        }
    }
}
