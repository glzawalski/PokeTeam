//
//  SearchModel.swift
//  PokeTeam App
//
//  Created by Gabriel Levis Zawalski on 21/05/22.
//

final class SearchModel {
    var count: Int
    var allPokemon: [Pokemon]
    var filteredPokemon: [Pokemon]
    
    init(from list: PokemonList) {
        self.count = list.count
        self.allPokemon = list.results
        self.filteredPokemon = list.results
    }
}
