//
//  DetailedPageView.swift
//  PokeTeam App
//
//  Created by Gabriel Zawalski on 27/09/22.
//

import SwiftUI

struct DetailedPageView: View {
    @EnvironmentObject var viewModel: DetailedPageViewModel
    @State var isShowingRegularSprite: Bool = true

    var body: some View {
        VStack(spacing: 10) {
            if let sprite = isShowingRegularSprite ? viewModel.model?.sprites.first : viewModel.model?.sprites.last,
               let url = URL(string: sprite) {
                AsyncImage(url: url)
                    .onTapGesture {
                        isShowingRegularSprite.toggle()
                    }
            }
            Text(viewModel.model?.name ?? "")
            Text("Height: \(viewModel.model?.height ?? "") meters")
            Text("Weight: \(viewModel.model?.weight ?? "") kilograms")
            HStack {
                ForEach(viewModel.model?.types ?? [], id: \.self) { type in
                    Text(type)
                }
            }
        }
        .task {
            await viewModel.fetchData()
        }
    }
}

struct DetailedPageView_Previews: PreviewProvider {
    static var previews: some View {
        let pokemon = Pokemon(name: "bulbasaur", url: "https://pokeapi.co/api/v2/pokemon/1/")
        DetailedPageView()
            .environmentObject(DetailedPageViewModel(pokemon: pokemon))
    }
}
