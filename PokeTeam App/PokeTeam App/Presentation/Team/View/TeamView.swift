//
//  TeamController.swift
//  PokeTeam App
//
//  Created by Gabriel Levis Zawalski on 25/05/22.
//

import UIKit

final class TeamView: UIViewController {
    
    private lazy var createTeamButton: UIButton = {
        let button: UIButton = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.setTitle("Add new team", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(didTapAddTeamButton), for: .touchUpInside)
        return button
    }()
    
    public lazy var pokemonTable: UITableView = {
        let tableView: UITableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .white
        tableView.register(PokemonTableViewCell.self, forCellReuseIdentifier: PokemonTableViewCell.identifier)
        tableView.showsVerticalScrollIndicator = false
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.isHidden = true
        return tableView
    }()
    
    private lazy var viewModel: TeamViewModelInput = {
        return TeamViewModel(output: self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addComponents()
        addConstraints()
    }
    
    @objc func didTapAddTeamButton() {
        let view = AddTeamMemberView()
        view.setOutput(self)
        view.modalPresentationStyle = .formSheet
        navigationController?.present(view, animated: true)
    }
}

// MARK: - COMPONENTS AND CONSTRAINTS
extension TeamView {
    
    private func addComponents() {
        view.addSubview(createTeamButton)
        view.addSubview(pokemonTable)
    }
    
    private func addConstraints() {
        createTeamButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 30).isActive = true
        createTeamButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        pokemonTable.topAnchor.constraint(equalTo: view.topAnchor, constant: 30).isActive = true
        pokemonTable.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        pokemonTable.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        pokemonTable.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

// MARK: - TABLE VIEW DELEGATE AND DATASOURCE
extension TeamView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.model.pokemons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PokemonTableViewCell.identifier, for: indexPath) as? PokemonTableViewCell else {
            return UITableViewCell()
        }
        
        let pokemonName = viewModel.model.pokemons[indexPath.row] ?? ""
        cell.configure(nameString: pokemonName)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Change pokemon slot
    }
}


// MARK: - ADD TEAM MEMBER OUTPUT
extension TeamView: AddTeamMemberViewOutput {
    
    func didSelect(_ pokemon: Pokemon) {
        viewModel.add(pokemon)
    }
}

// MARK: - VIEW MODEL OUTPUT
extension TeamView: TeamViewModelOutput {
    
    func didFinishTeam() {
        navigationController?.dismiss(animated: true)
        createTeamButton.isHidden = true
        pokemonTable.isHidden = false
        pokemonTable.reloadData()
    }
}
