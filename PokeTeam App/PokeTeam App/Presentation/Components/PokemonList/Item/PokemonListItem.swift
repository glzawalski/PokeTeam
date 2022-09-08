//
//  PokemonListItem.swift
//  PokeTeam App
//
//  Created by Gabriel Zawalski on 08/09/22.
//

import SwiftUI

struct PokemonListItem: View {
    var pokemon: Pokemon

    var body: some View {
        Text(pokemon.name)
            .padding(.top, 10)
            .padding(.bottom, 10)
    }
}

struct PokemonListItem_Previews: PreviewProvider {
    static var previews: some View {
        let pokemon = Pokemon(name: "Gengar", url: "")
        PokemonListItem(pokemon: pokemon)
    }
}
