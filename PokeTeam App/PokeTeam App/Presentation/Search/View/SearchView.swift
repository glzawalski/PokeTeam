//
//  SearchView.swift
//  PokeTeam App
//
//  Created by Gabriel Zawalski on 08/09/22.
//

import SwiftUI

struct SearchView: View {
    @EnvironmentObject var viewModel: SearchViewModel
    @State private var filterText: String = ""

    var filteredPokemon: [Pokemon] {
        if filterText.isEmpty {
            return viewModel.model?.allPokemon ?? []
        } else {
            return viewModel.model?.allPokemon.filter {
                $0.name.localizedCaseInsensitiveContains(filterText)
            } ?? []
        }
    }

    // TODO: Remove NavigationView once all app is in shape with SwiftUI
    var body: some View {
        NavigationView{
            List {
                ForEach(filteredPokemon) { pokemon in
                    NavigationLink {
                        DetailedPage(selectedPokemon: pokemon)
                    } label: {
                        PokemonListItem(pokemon: pokemon)
                    }
                }
            }
            .searchable(text: $filterText)
            .navigationTitle("Pokémon List")
            .navigationBarTitleDisplayMode(.automatic)
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
