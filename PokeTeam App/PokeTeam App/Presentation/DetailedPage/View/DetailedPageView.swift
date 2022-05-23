//
//  DetailedPageView.swift
//  PokeTeam App
//
//  Created by Gabriel Levis Zawalski on 21/05/22.
//

import UIKit

class DetailedPageView: UIViewController {
    
    var selectedPokemon: Pokemon?
    
    private lazy var idLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var nameLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var heightLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var weightLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var viewModel: DetailedPageViewModelInput = {
        return DetailedPageViewModel(output: self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addComponents()
        addConstraints()
        
        guard let selectedPokemon = selectedPokemon else { return }

        viewModel.fetchData(for: selectedPokemon)
    }
    
    private func configure() {
        guard let model = viewModel.model else { return }
        
        idLabel.text = model.id
        nameLabel.text = model.name
        heightLabel.text = model.height
        weightLabel.text = model.weight
        
    }
}

// MARK: - COMPONENTS AND CONSTRAINTS
extension DetailedPageView {
    
    private func addComponents() {
        view.addSubview(idLabel)
        view.addSubview(nameLabel)
        view.addSubview(heightLabel)
        view.addSubview(weightLabel)
    }
    
    private func addConstraints() {
        idLabel.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        idLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        
        nameLabel.topAnchor.constraint(equalTo: idLabel.bottomAnchor, constant: 10).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        
        heightLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10).isActive = true
        heightLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        
        weightLabel.topAnchor.constraint(equalTo: heightLabel.bottomAnchor, constant: 10).isActive = true
        weightLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    }
}

// MARK: - VIEW MODEL OUTPUT
extension DetailedPageView: DetailedPageViewModelOutput {
    
    func didFetchData() {
        DispatchQueue.main.async {
            self.configure()
        }
    }
    
    func didFailFetchData() {
        DispatchQueue.main.async {
            self.configure()
        }
    }
}

