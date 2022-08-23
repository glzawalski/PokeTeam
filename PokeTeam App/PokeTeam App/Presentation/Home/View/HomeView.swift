//
//  HomeView.swift
//  PokeTeam App
//
//  Created by Gabriel Zawalski on 22/08/22.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var viewModel: HomeViewModel

    let defaults = UserDefaults.standard
    
    var body: some View {
        List {
            ForEach(viewModel.model?.types ?? []) { type in
                HStack {
                    Text(type.name)
                }
            }
        }
        .task {
            await viewModel.fetchData()
        }
    }
}

// TODO: Add scroll to favorite type on list
// TODO: defaults.set(typeName, forKey: "FavoriteType")
// TODO: Highlight favorite type

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(HomeViewModel())
    }
}
