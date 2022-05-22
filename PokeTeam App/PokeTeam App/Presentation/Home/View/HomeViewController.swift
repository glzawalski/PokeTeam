//
//  HomeViewController.swift
//  PokeTeam App
//
//  Created by Gabriel Levis Zawalski on 21/05/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    let defaults = UserDefaults.standard
    
    private lazy var pokemonTypeTable: UITableView = {
        let tableView: UITableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.register(PokemonTypeTableViewCell.self, forCellReuseIdentifier: PokemonTypeTableViewCell.identifier)
        tableView.showsVerticalScrollIndicator = false
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        scrollToFavoriteType()
    }
    
    private func scrollToFavoriteType() {
        guard let index = viewModel.model?.types.firstIndex(where: { $0.name == defaults.string(forKey: "FavoriteType") }) else { return }
        
        let indexPath: IndexPath = IndexPath(row: index, section: .zero)
        pokemonTypeTable.selectRow(at: indexPath, animated: false, scrollPosition: .none)
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
        return viewModel.model?.count ?? .zero
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PokemonTypeTableViewCell.identifier, for: indexPath) as? PokemonTypeTableViewCell,
              let typeName = viewModel.model?.types[indexPath.row].name else {
            return UITableViewCell()
        }
        
        cell.configure(typeString: typeName)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let typeName = viewModel.model?.types[indexPath.row].name else { return }
        
        defaults.set(typeName, forKey: "FavoriteType")
    }
}

// MARK: - VIEW MODEL OUTPUT
extension HomeViewController: HomeViewModelOutput {
    
    func didFetchData() {
        DispatchQueue.main.async {
            self.pokemonTypeTable.reloadData()
        }
    }
    
    func didFailFetchData() {
        DispatchQueue.main.async {
            self.pokemonTypeTable.reloadData()
        }
    }
}
