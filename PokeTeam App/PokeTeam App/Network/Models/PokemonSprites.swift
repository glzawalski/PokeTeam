//
//  PokemonSprites.swift
//  PokeTeam App
//
//  Created by Gabriel Levis Zawalski on 22/05/22.
//

struct PokemonSprites: Decodable {
    
    var frontDefault: String
    var shinyDefault: String
    
    var allSprites: [String] {
        return [frontDefault, shinyDefault]
    }
    
    private enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
        case shinyDefault = "front_shiny"
    }
}
