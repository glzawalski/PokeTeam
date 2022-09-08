//
//  SearchView.swift
//  PokeTeam App
//
//  Created by Gabriel Zawalski on 08/09/22.
//

import SwiftUI

struct SearchView: View {
    @EnvironmentObject var viewModel: SearchViewModel

    var body: some View {
        List {
            ForEach(viewModel.model?.filteredPokemon ?? []) { pokemon in
                PokemonListItem(pokemon: pokemon)
            }
        }
        .task {
            await viewModel.fetchData()
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
            .environmentObject(SearchViewModel())
            .environmentObject(AppState())
    }
}
