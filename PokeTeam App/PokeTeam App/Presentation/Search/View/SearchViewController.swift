//
//  SearchViewController.swift
//  PokeTeam App
//
//  Created by Gabriel Levis Zawalski on 21/05/22.
//

import UIKit

class SearchViewController: UIViewController {
    
    private lazy var searchBar: UISearchBar = {
        let bar: UISearchBar = UISearchBar()
        bar.translatesAutoresizingMaskIntoConstraints = false
        bar.delegate = self
        return bar
    }()
    
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
        view.addSubview(searchBar)
        view.addSubview(pokemonTable)
    }
    
    private func addConstraints() {
        searchBar.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        searchBar.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        searchBar.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        pokemonTable.topAnchor.constraint(equalTo: searchBar.bottomAnchor).isActive = true
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
        
        let pokemonName = viewModel.model?.filteredPokemon[indexPath.row].name ?? ""
        cell.configure(nameString: pokemonName)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let pokemonName = viewModel.model?.filteredPokemon[indexPath.row].name else { return }
        
        let detailedPage = DetailedPageView()
        detailedPage.selectedPokemon = pokemonName
        detailedPage.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(detailedPage, animated: true)
    }
}

// MARK: - SEARCH BAR DELEGATE
extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filterItems(with: searchText)
        
        DispatchQueue.main.async {
            self.pokemonTable.reloadData()
        }
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
