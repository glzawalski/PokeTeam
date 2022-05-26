//
//  AddTeamMemberView.swift
//  PokeTeam App
//
//  Created by Gabriel Levis Zawalski on 25/05/22.
//

import UIKit

protocol AddTeamMemberViewOutput {
    func didSelect(_ pokemon: Pokemon)
}

class AddTeamMemberView: SearchViewController {
    
    private var output: AddTeamMemberViewOutput?
    
    public func setOutput(_ output: AddTeamMemberViewOutput) {
        self.output = output
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let pokemon = viewModel.model?.filteredPokemon[indexPath.row] else { return }
        
        output?.didSelect(pokemon)
    }
}
