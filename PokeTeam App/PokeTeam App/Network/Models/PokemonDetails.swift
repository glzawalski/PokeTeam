//
//  PokemonDetails.swift
//  PokeTeam App
//
//  Created by Gabriel Levis Zawalski on 21/05/22.
//

struct PokemonDetails: Decodable {
    
    var name: String
    var height: Int
    var weight: Int
    var types: [PokemonDetailsType]
    var sprites: PokemonSprites
}
