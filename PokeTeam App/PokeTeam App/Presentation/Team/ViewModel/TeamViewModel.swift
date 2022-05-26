//
//  TeamViewModel.swift
//  PokeTeam App
//
//  Created by Gabriel Levis Zawalski on 25/05/22.
//

import Foundation

protocol TeamViewModelInput {
    var model: TeamModel { get }
    
    func add(_ pokemon: Pokemon)
}

protocol TeamViewModelOutput {
    func didFinishTeam()
}

final class TeamViewModel: TeamViewModelInput {
    
    let defaults = UserDefaults.standard
    
    var model: TeamModel = TeamModel()
    var output: TeamViewModelOutput
    
    init(output: TeamViewModelOutput) {
        self.output = output
    }
    
    public func add(_ pokemon: Pokemon) {
        let slot = model.pokemons.count
        model.pokemons[slot] = pokemon.name
        saveTeam()
        
        if model.pokemons.count >= model.limit - 1 {
            output.didFinishTeam()
        }
    }
    
    private func saveTeam() {
        let encoder = PropertyListEncoder()
        
        guard let data = try? encoder.encode(model.pokemons) else {
            return
        }
        
        defaults.set(data, forKey: "Team")
    }
}
