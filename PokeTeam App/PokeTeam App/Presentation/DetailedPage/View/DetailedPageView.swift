//
//  DetailedPageView.swift
//  PokeTeam App
//
//  Created by Gabriel Levis Zawalski on 21/05/22.
//

import UIKit

class DetailedPageView: UIViewController {
    
    var selectedPokemon: Pokemon?
    
    private lazy var spriteImage: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
    
    private lazy var typeStack: UIStackView = {
        let stack: UIStackView = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 10
        return stack
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
        
        nameLabel.text = model.name
        heightLabel.text = "Height: \(model.height) meters"
        weightLabel.text = "Weight: \(model.weight) kilograms"
        
        
        model.types.forEach {
            let label: UILabel = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = $0
            typeStack.addArrangedSubview(label)
        }
        
        guard let firstSprite = model.sprites.first,
              let url = URL(string: firstSprite),
              let data = try? Data(contentsOf: url) else { return }
        
        spriteImage.image = UIImage(data: data)
    }
}

// MARK: - COMPONENTS AND CONSTRAINTS
extension DetailedPageView {
    
    private func addComponents() {
        view.addSubview(spriteImage)
        view.addSubview(nameLabel)
        view.addSubview(heightLabel)
        view.addSubview(weightLabel)
        view.addSubview(typeStack)
    }
    
    private func addConstraints() {
        spriteImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        spriteImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        nameLabel.topAnchor.constraint(equalTo: spriteImage.bottomAnchor, constant: 10).isActive = true
        nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        heightLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10).isActive = true
        heightLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        weightLabel.topAnchor.constraint(equalTo: heightLabel.bottomAnchor, constant: 10).isActive = true
        weightLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        typeStack.topAnchor.constraint(equalTo: weightLabel.bottomAnchor, constant: 10).isActive = true
        typeStack.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
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

