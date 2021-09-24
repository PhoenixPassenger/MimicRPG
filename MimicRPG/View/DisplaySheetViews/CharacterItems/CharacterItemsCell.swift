//
//  CharacterItemsCell.swift
//  MimicRPG
//
//  Created by Rodrigo Silva Ribeiro on 23/09/21.
//

import Foundation
import UIKit
class CharacterItemsCell: UITableViewCell {

    lazy var itemNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.josefinSansBold17()
        return label
    }()

    lazy var itemDescriptionTextLabel: UITextView = {
        let field = UITextView()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.font = UIFont.systemFont(ofSize: 17.0)
        field.textColor = .black
        field.backgroundColor = .pinkT20
        field.isEditable = false
        field.layer.borderWidth = 1
        field.layer.cornerRadius = 5
        field.textContainer.lineBreakMode = .byWordWrapping
        field.textContainerInset = UIEdgeInsets(top: 3, left: 10, bottom: 0, right: 10)
        return field
    }()

    lazy var stack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [itemNameLabel, itemDescriptionTextLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .fill
        stack.spacing = 15
        self.addSubview(stack)
        return stack
    }()

    lazy var itemUsesBackground: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        let color = UIImage.imageWithColor(color: .pinkT20)
        view.image = color
        self.addSubview(view)
        return view
    }()

    lazy var itemUsesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.josefinSansBold17()
        label.textAlignment = .center
        label.textColor = .black
        label.backgroundColor = .clear
        label.text = "Uses".localized()
        self.addSubview(label)
        return label
    }()

    lazy var itemUsesTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(label)
        label.font = UIFont.josefinSansBold17()
        label.textColor = .black
        label.backgroundColor = .pinkT20
        label.textAlignment = .center
        label.layer.borderColor = UIColor.auburnT20.cgColor
        return label
    }()

    override func draw(_ rect: CGRect) {
        self.layer.borderWidth = 3
        self.layer.cornerRadius = 5
        self.layer.backgroundColor = UIColor.auburnT20.cgColor
        self.layer.borderColor = UIColor.auburnT20.cgColor
    }

    func set(itemName: String, itemDescription: String, itemUses: Int) {
        configureLayout()
        self.backgroundColor = .auburnT20
        self.selectionStyle = .none
        itemNameLabel.text = itemName
        itemDescriptionTextLabel.text = itemDescription
        itemUsesTextLabel.text = "\(itemUses)"
    }

    private func configureLayout() {
        self.sendSubviewToBack(itemUsesBackground)
        NSLayoutConstraint.activate([
            stack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stack.topAnchor.constraint(equalTo: self.topAnchor),
            stack.bottomAnchor.constraint(equalTo: self.bottomAnchor),

            itemNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            itemNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),

            itemUsesBackground.leadingAnchor.constraint(equalTo: self.trailingAnchor, constant: -118),
            itemUsesBackground.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            itemUsesBackground.heightAnchor.constraint(equalToConstant: 44),

            itemUsesLabel.leadingAnchor.constraint(equalTo: itemUsesBackground.leadingAnchor),
            itemUsesLabel.centerYAnchor.constraint(equalTo: itemUsesBackground.centerYAnchor),
            itemUsesTextLabel.leadingAnchor.constraint(equalTo: itemUsesLabel.trailingAnchor),
            itemUsesTextLabel.centerYAnchor.constraint(equalTo: itemUsesBackground.centerYAnchor),

            itemDescriptionTextLabel.leadingAnchor.constraint(equalTo: stack.leadingAnchor)
        ])
    }
}
