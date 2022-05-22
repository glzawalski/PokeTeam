//
//  SearchViewController.swift
//  PokeTeam App
//
//  Created by Gabriel Levis Zawalski on 21/05/22.
//

import UIKit

class SearchViewController: UIViewController {
    
    private lazy var pokemonTable: UITableView = {
        let tableView: UITableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .white
        tableView.register(PokemonTableViewCell.self, forCellReuseIdentifier: PokemonTableViewCell.identifier)
        tableView.showsVerticalScrollIndicator = false
        tableView.tableFooterView = UIView(frame: .zero)
        return tableView
    }()
    
    private lazy var viewModel: SearchViewModelInput = {
        return SearchViewModel(output: self)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        addComponents()
        addConstraints()
        viewModel.fetchData()
    }
}

// MARK: - COMPONENTS AND CONSTRAINTS
extension SearchViewController {
    
    private func addComponents() {
        view.addSubview(pokemonTable)
    }
    
    private func addConstraints() {
        pokemonTable.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        pokemonTable.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        pokemonTable.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        pokemonTable.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

// MARK: - TABLE VIEW DELEGATE AND DATASOURCE
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.model?.count ?? .zero
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PokemonTableViewCell.identifier, for: indexPath) as? PokemonTableViewCell else {
            return UITableViewCell()
        }
        
        let typeString: String = viewModel.model?.names[indexPath.row].name ?? ""
        cell.configure(nameString: typeString)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let pokemon = viewModel.model?.names[indexPath.row].name else { return }
        
        let detailedPage = DetailedPageView()
        detailedPage.selectedPokemon = pokemon
        detailedPage.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(detailedPage, animated: true)
    }
}

// MARK: - VIEW MODEL OUTPUT
extension SearchViewController: SearchViewModelOutput {
    
    func didFetchData() {
        DispatchQueue.main.async {
            self.pokemonTable.reloadData()
        }
    }
    
    func didFailFetchData() {
        DispatchQueue.main.async {
            self.pokemonTable.reloadData()
        }
    }
}
