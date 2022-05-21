//
//  PokemonTableViewCell.swift
//  PokeTeam App
//
//  Created by Gabriel Levis Zawalski on 21/05/22.
//

import UIKit

final class PokemonTableViewCell: UITableViewCell {
    
    static let identifier: String = String(describing: PokemonTableViewCell.self)
    
    fileprivate lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
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
    
    func configure(nameString: String) {
        nameLabel.text = nameString
    }
}

// MARK: - COMPONENTS AND CONSTRAINTS
extension PokemonTableViewCell {
    
    private func addComponents() {
        contentView.addSubview(nameLabel)
    }
    
    private func addConstraints() {
        nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        nameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
    }
}
