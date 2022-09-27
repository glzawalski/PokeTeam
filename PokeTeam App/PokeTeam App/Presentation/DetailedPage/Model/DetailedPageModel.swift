//
//  DetailedPageModel.swift
//  PokeTeam App
//
//  Created by Gabriel Levis Zawalski on 21/05/22.
//

final class DetailedPageModel {
    var name: String
    var height: String
    var weight: String
    var types: [String]
    var sprites: [String]
    
    init(from details: PokemonDetails) {
        self.name = details.name
        let convertedHeight: Float = Float(details.height) / 10
        self.height = String(convertedHeight)
        let convertedWeight: Float = Float(details.weight) / 100
        self.weight = String(convertedWeight)
        self.types = details.types.map { $0.type.name }
        self.sprites = details.sprites.allSprites
    }
}
