//
//  PokemonTypeTableViewCell.swift
//  PokeTeam App
//
//  Created by Gabriel Levis Zawalski on 21/05/22.
//

import UIKit

final class PokemonTypeTableViewCell: UITableViewCell {
    
    static let identifier: String = String(describing: PokemonTypeTableViewCell.self)
    
    fileprivate lazy var typeNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.text = "Couldn`t load Pokemon type list"
        return label
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    private func setupView() {
        selectionStyle = .none
        backgroundColor = .clear
        addComponents()
        addConstraints()
    }
    
    func configure(typeString: String) {
        typeNameLabel.text = typeString
    }
}

// MARK: - COMPONENTS AND CONSTRAINTS
extension PokemonTypeTableViewCell {
    
    private func addComponents() {
        contentView.addSubview(typeNameLabel)
    }
    
    private func addConstraints() {
        typeNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        typeNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        typeNameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
    }
}
