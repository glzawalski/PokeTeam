//
//  AppState.swift
//  PokeTeam App
//
//  Created by Gabriel Zawalski on 24/08/22.
//

import Foundation

class AppState: ObservableObject {
    @Published var favoriteType: String = loadFavoriteType() {
        willSet {
            UserDefaults.standard.set(newValue, forKey: "FavoriteType")
        }
    }
}

func loadFavoriteType() -> String {
    return UserDefaults.standard.string(forKey: "FavoriteType") ?? ""
}
