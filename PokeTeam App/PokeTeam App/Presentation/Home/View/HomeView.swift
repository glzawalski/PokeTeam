//
//  HomeView.swift
//  PokeTeam App
//
//  Created by Gabriel Zawalski on 22/08/22.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var viewModel: HomeViewModel
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        List {
            ForEach(viewModel.model?.types ?? []) { type in
                HStack {
                    Text(type.name)
                    Spacer()
                    let isFavorite = type.name == appState.favoriteType
                    Image(systemName: isFavorite ? "star.fill" : "star")
                        .foregroundColor(isFavorite ? .yellow : .gray)
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    appState.favoriteType = type.name
                }
            }
        }
        .task {
            await viewModel.fetchData()
        }
    }
}

// TODO: Add scroll to favorite type on list
// TODO: Highlight favorite type

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(HomeViewModel())
            .environmentObject(AppState())
    }
}
