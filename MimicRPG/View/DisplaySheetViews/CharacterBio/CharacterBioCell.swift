//
//  CharacterBioCell.swift
//  MimicRPG
//
//  Created by Rodrigo Silva Ribeiro on 21/09/21.
//

import Foundation
import UIKit
class CharacterBioCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.accessoryType = .disclosureIndicator
        self.backgroundColor = .darkText
        self.selectionStyle = .none
        self.tintColor = .blue
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setupUI()
    }

    // MARK: - Properties
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .blue
        label.font = UIFont.boldSystemFont(ofSize: 26)
        self.addSubview(label)
        return label
    }()
    
    lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkText
        label.font = UIFont.boldSystemFont(ofSize: 26)
        self.addSubview(label)
        return label
    }()
    
    lazy var stack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleLabel, valueLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .fill
        stack.spacing = 5
        self.addSubview(stack)
        return stack
    }()

    func set( titleItem: String, valueItem: String) {
        titleLabel.text = titleItem
        valueLabel.text = valueItem
    }
    
}
extension CharacterBioCell {
    private func setupUI() {
        valueLabel.numberOfLines = 1
        NSLayoutConstraint.activate([
            stack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stack.topAnchor.constraint(equalTo: self.topAnchor),
            stack.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: stack.leadingAnchor, constant: 16),
            titleLabel.topAnchor.constraint(equalTo: stack.topAnchor, constant: 10),
            
            valueLabel.leadingAnchor.constraint(equalTo: stack.leadingAnchor),
            valueLabel.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
}
