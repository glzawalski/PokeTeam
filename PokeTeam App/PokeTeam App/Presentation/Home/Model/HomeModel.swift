//
//  HomeModel.swift
//  PokeTeam App
//
//  Created by Gabriel Levis Zawalski on 21/05/22.
//

final class HomeModel {
    var count: Int
    var types: [PokemonTypeListItem]

    init(from list: PokemonTypeList) {
        count = list.count
        types = list.results
    }
}
