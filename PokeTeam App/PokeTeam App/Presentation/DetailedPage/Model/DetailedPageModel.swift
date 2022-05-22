//
//  DetailedPageModel.swift
//  PokeTeam App
//
//  Created by Gabriel Levis Zawalski on 21/05/22.
//

final class DetailedPageModel {
    
    var id: String
    var name: String
    var height: String
    var weight: String
    
    init(from details: PokemonDetails) {
        self.id = String(details.id)
        self.name = details.name
        self.height = String(details.height)
        self.weight = String(details.weight)
    }
}
