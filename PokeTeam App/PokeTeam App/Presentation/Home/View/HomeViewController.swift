//
//  HomeViewController.swift
//  PokeTeam App
//
//  Created by Gabriel Levis Zawalski on 21/05/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    private lazy var pokemonTypeTable: UITableView = {
        let tableView: UITableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .white
        tableView.register(PokemonTypeTableViewCell.self, forCellReuseIdentifier: PokemonTypeTableViewCell.identifier)
        tableView.showsVerticalScrollIndicator = false
        tableView.tableFooterView = UIView(frame: .zero)
        return tableView
    }()
    
    private lazy var viewModel: HomeViewModelInput = {
        return HomeViewModel(output: self)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        addComponents()
        addConstraints()
        viewModel.fetchData()
    }
}

// MARK: - COMPONENTS AND CONSTRAINTS
extension HomeViewController {
    
    private func addComponents() {
        view.addSubview(pokemonTypeTable)
    }
    
    private func addConstraints() {
        pokemonTypeTable.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        pokemonTypeTable.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        pokemonTypeTable.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        pokemonTypeTable.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

// MARK: - TABLE VIEW DELEGATE AND DATASOURCE
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.model?.pokemonTypeCount ?? .zero
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PokemonTypeTableViewCell.identifier, for: indexPath) as? PokemonTypeTableViewCell else {
            return UITableViewCell()
        }
        
        let typeString: String = viewModel.model?.pokemonTypeNames[indexPath.row].name ?? ""
        cell.configure(typeString: typeString)
        
        return cell
    }
}

