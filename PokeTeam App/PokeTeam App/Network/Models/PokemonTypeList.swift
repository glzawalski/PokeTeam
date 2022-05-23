//
//  PokemonTypeList.swift
//  PokeTeam App
//
//  Created by Gabriel Levis Zawalski on 21/05/22.
//

struct PokemonTypeList: Decodable {
    var count: Int
    var results: [PokemonTypeListItem]
}
