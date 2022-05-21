//
//  HomeModel.swift
//  PokeTeam App
//
//  Created by Gabriel Levis Zawalski on 21/05/22.
//

final class HomeModel {
    
    var pokemonTypeCount: Int
    var pokemonTypeNames: [PokemonType]
    
    init(from list: PokemonTypeList) {
        pokemonTypeCount = list.count
        pokemonTypeNames = list.results
    }
}
