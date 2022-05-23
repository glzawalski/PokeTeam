//
//  DetailedPageViewModel.swift
//  PokeTeam App
//
//  Created by Gabriel Levis Zawalski on 21/05/22.
//

import Foundation

protocol DetailedPageViewModelInput {
    var model: DetailedPageModel? { get }
    
    func fetchData(for pokemon: Pokemon)
}

protocol DetailedPageViewModelOutput {
    func didFetchData()
    func didFailFetchData()
}

final class DetailedPageViewModel: DetailedPageViewModelInput {
    
    var output: DetailedPageViewModelOutput
    private var networkManager: NetworkManagerInput
    var model: DetailedPageModel?
    
    init(output: DetailedPageViewModelOutput,
         networkManager: NetworkManagerInput = NetworkManager()) {
        self.output = output
        self.networkManager = networkManager
    }
}

// MARK: - NETWORKING
extension DetailedPageViewModel {
    internal func fetchData(for pokemon: Pokemon) {
        networkManager.fetch(PokemonDetails.self,
                             url: pokemon.url) { response in
            switch response {
            case .failure:
                self.output.didFailFetchData()
            case .success(let details):
                self.model = DetailedPageModel(from: details)
                self.output.didFetchData()
            }
        }
    }
}
